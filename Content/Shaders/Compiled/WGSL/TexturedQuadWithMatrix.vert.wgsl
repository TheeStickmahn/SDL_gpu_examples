struct S {
  MatrixTransform : mat4x4<f32>,
}

@group(1u) @binding(0u) var<uniform> UniformBlock : S;

var<private> v : vec2<f32>;

var<private> v_1 : vec4<f32>;

fn main_inner(v_2 : vec4<f32>, v_3 : vec2<f32>) {
  let v_4 = (v_2 * UniformBlock.MatrixTransform);
  v = v_3;
  v_1 = v_4;
}

struct tint_symbol_1 {
  @location(0u)
  m : vec2<f32>,
  @builtin(position)
  tint_symbol : vec4<f32>,
}

@vertex
fn main(@location(0u) v_5 : vec4<f32>, @location(1u) v_6 : vec2<f32>) -> tint_symbol_1 {
  main_inner(v_5, v_6);
  return tint_symbol_1(v, v_1);
}
