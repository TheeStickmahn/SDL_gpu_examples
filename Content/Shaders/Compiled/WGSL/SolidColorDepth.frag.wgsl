struct S {
  NearPlane : f32,
  FarPlane : f32,
}

@group(3u) @binding(0u) var<uniform> UBO : S;

var<private> v : vec4<f32>;

var<private> v_1 : f32;

fn main_inner(v_2 : vec4<f32>, v_3 : vec4<f32>) {
  let v_4 = UBO.NearPlane;
  let v_5 = UBO.FarPlane;
  v = v_2;
  v_1 = ((((2.0f * v_4) * v_5) / ((v_5 + v_4) - (((v_3.z * 2.0f) - 1.0f) * (v_5 - v_4)))) / v_5);
}

struct tint_symbol_1 {
  @location(0u)
  m : vec4<f32>,
  @builtin(frag_depth)
  tint_symbol : f32,
}

@fragment
fn main(@location(0u) v_6 : vec4<f32>, @builtin(position) v_7 : vec4<f32>) -> tint_symbol_1 {
  main_inner(v_6, v_7);
  return tint_symbol_1(v, v_1);
}
