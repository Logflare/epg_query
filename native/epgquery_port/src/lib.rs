use rustler::NifTuple;
use rustler::NifUntaggedEnum;
use rustler::NifResult;
use rustler::Atom;
use pg_parse::ast::Node;
// use serde_json::{Result, Value};
use serde::Deserialize;


mod atoms {
    rustler::atoms! {
      ok,
      error,
    }
}

#[derive(NifTuple)]
struct Response {
    status: Atom,
    message: String,
}



#[derive(Debug, Deserialize)]
pub struct Nodes {
    #[serde(deserialize_with = "pg_parse::serde::deserialize_node_array")]
    values: Vec<Node>,
}




#[rustler::nif]
fn parse(query: &str) -> NifResult<Response> {
    let result = pg_parse::parse_to_json(&query);

    match result {
        Ok(v) => Ok(Response{status: atoms::ok(), message: v}),
        Err(v) => Ok(Response{status: atoms::error(), message: v.to_string()}),
    }
}


#[rustler::nif]
fn to_string(json: &str) -> NifResult<Response> {
    let nodes: Nodes = serde_json::from_str(json).unwrap();
    
    let mut parts = vec![];
    for node in nodes.values {
        parts.push(
            node.to_string()
        )
    }

    return Ok(Response{status: atoms::ok(), message: parts.join("\n")});
}

rustler::init!("Elixir.EpgQuery.Port", [parse, to_string]);



#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;
    use pg_parse::ast::Node;
    #[test]
    fn test_add() {

        let result = pg_parse::parse("SELECT * FROM contacts");
        assert!(result.is_ok());
        let result = result.unwrap();
        assert!(matches!(*&result[0], Node::SelectStmt(_)));
        println!("{:?}", &result[0]);
        println!("{:?}", pg_parse::parse_to_json("SELECT * FROM contacts").unwrap());



        // We can also convert back to a string
        assert_eq!(result[0].to_string(), "SELECT * FROM contactss");

    }

}