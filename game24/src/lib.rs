use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    fn alert(s: &str);
}

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

macro_rules! console_log {
    ($($t:tt)*) => (log(&format_args!($($t)*).to_string()))
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum Operation {
    Add,
    Subtract,
    Multiply,
    Divide,
}

impl Operation {
    fn apply(&self, a: f64, b: f64) -> f64 {
        match self {
            Operation::Add => a + b,
            Operation::Subtract => a - b,
            Operation::Multiply => a * b,
            Operation::Divide => if b != 0.0 { a / b } else { f64::NAN },
        }
    }

    fn to_string(&self) -> &'static str {
        match self {
            Operation::Add => "+",
            Operation::Subtract => "-",
            Operation::Multiply => "*",
            Operation::Divide => "/",
        }
    }
}

#[derive(Debug, Clone)]
struct Expression {
    value: f64,
    formula: String,
}

impl Expression {
    fn new(value: f64) -> Self {
        Expression {
            value,
            formula: value.to_string(),
        }
    }

    fn combine(&self, other: &Expression, op: Operation) -> Expression {
        let new_value = op.apply(self.value, other.value);
        let new_formula = format!("({} {} {})", self.formula, op.to_string(), other.formula);
        Expression {
            value: new_value,
            formula: new_formula,
        }
    }
}

fn solve_recursive(expressions: Vec<Expression>) -> Vec<Expression> {
    if expressions.len() == 1 {
        return expressions;
    }

    let mut results = Vec::new();
    let operations = [Operation::Add, Operation::Subtract, Operation::Multiply, Operation::Divide];

    for i in 0..expressions.len() {
        for j in i + 1..expressions.len() {
            let expr_a = &expressions[i];
            let expr_b = &expressions[j];
            
            let mut remaining = Vec::new();
            for k in 0..expressions.len() {
                if k != i && k != j {
                    remaining.push(expressions[k].clone());
                }
            }

            for &op in &operations {
                let result1 = op.apply(expr_a.value, expr_b.value);
                let result2 = op.apply(expr_b.value, expr_a.value);
                
                if result1.is_finite() {
                    let combined1 = expr_a.combine(expr_b, op);
                    let mut new_expressions = remaining.clone();
                    new_expressions.push(combined1);
                    results.extend(solve_recursive(new_expressions));
                }
                
                if result2.is_finite() && op != Operation::Add && op != Operation::Multiply {
                    let combined2 = expr_b.combine(expr_a, op);
                    let mut new_expressions = remaining.clone();
                    new_expressions.push(combined2);
                    results.extend(solve_recursive(new_expressions));
                }
            }
        }
    }

    results
}

#[wasm_bindgen]
pub fn solve_game24(a: f64, b: f64, c: f64, d: f64) -> String {
    let initial_expressions = vec![
        Expression::new(a),
        Expression::new(b),
        Expression::new(c),
        Expression::new(d),
    ];
    
    let all_expressions = solve_recursive(initial_expressions);
    
    for expr in all_expressions {
        if (expr.value - 24.0).abs() < 0.0001 {
            return expr.formula;
        }
    }
    
    "No solution found".to_string()
}

#[wasm_bindgen]
pub fn greet(name: &str) {
    alert(&format!("Hello, {}!", name));
}