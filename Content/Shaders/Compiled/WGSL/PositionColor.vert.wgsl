var<private> v : vec4<f32>;

var<private> v_1 : vec4<f32>;

fn main_inner(v_2 : vec3<f32>, v_3 : vec4<f32>) {
  v = v_3;
  v_1 = vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f);
}

struct tint_symbol_1 {
  @location(0u)
  m : vec4<f32>,
  @builtin(position)
  tint_symbol : vec4<f32>,
}

@vertex
fn main(@location(0u) v_4 : vec3<f32>, @location(1u) v_5 : vec4<f32>) -> tint_symbol_1 {
  main_inner(v_4, v_5);
  return tint_symbol_1(v, v_1);
}
