var<private> v : vec2<f32>;

var<private> v_1 : vec4<f32>;

fn main_inner(v_2 : u32) {
  let v_3 = vec2<f32>(f32(((v_2 << 1u) & 2u)), f32((v_2 & 2u)));
  let v_4 = ((v_3 * vec2<f32>(2.0f, -2.0f)) + vec2<f32>(-1.0f, 1.0f));
  v = v_3;
  v_1 = vec4<f32>(v_4.x, v_4.y, 0.0f, 1.0f);
}

struct tint_symbol_1 {
  @location(0u)
  m : vec2<f32>,
  @builtin(position)
  tint_symbol : vec4<f32>,
}

@vertex
fn main(@builtin(vertex_index) v_5 : u32) -> tint_symbol_1 {
  main_inner(v_5);
  return tint_symbol_1(v, v_1);
}
