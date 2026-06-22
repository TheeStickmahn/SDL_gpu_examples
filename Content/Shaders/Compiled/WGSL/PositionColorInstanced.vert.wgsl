var<private> v : vec4<f32>;

var<private> v_1 : vec4<f32>;

fn main_inner(v_2 : vec3<f32>, v_3 : vec4<f32>, v_4 : u32) {
  let v_5 = ((v_2 * 0.25f) - vec3<f32>(0.75f, 0.75f, 0.0f));
  let v_6 = vec4<f32>((v_5.x + (f32((v_4 % 4u)) * 0.5f)), (v_5.y + (floor(f32((v_4 / 4u))) * 0.5f)), v_5.z, 1.0f);
  v = v_3;
  v_1 = v_6;
}

struct tint_symbol_1 {
  @location(0u)
  m : vec4<f32>,
  @builtin(position)
  tint_symbol : vec4<f32>,
}

@vertex
fn main(@location(0u) v_7 : vec3<f32>, @location(1u) v_8 : vec4<f32>, @builtin(instance_index) v_9 : u32) -> tint_symbol_1 {
  main_inner(v_7, v_8, v_9);
  return tint_symbol_1(v, v_1);
}
