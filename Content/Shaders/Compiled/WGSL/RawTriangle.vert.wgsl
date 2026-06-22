var<private> v : vec4<f32>;

var<private> v_1 : vec4<f32>;

fn main_inner(v_2 : u32) {
  var v_3 : vec4<f32>;
  var v_4 : vec2<f32>;
  if ((v_2 == 0u)) {
    v_3 = vec4<f32>(1.0f, 0.0f, 0.0f, 1.0f);
    v_4 = vec2<f32>(-1.0f);
  } else {
    var v_5 : vec4<f32>;
    var v_6 : vec2<f32>;
    if ((v_2 == 1u)) {
      v_5 = vec4<f32>(0.0f, 1.0f, 0.0f, 1.0f);
      v_6 = vec2<f32>(1.0f, -1.0f);
    } else {
      let v_7 = (v_2 == 2u);
      let v_8 = select(vec4<f32>(), vec4<f32>(0.0f, 0.0f, 1.0f, 1.0f), vec4<bool>(v_7, v_7, v_7, v_7));
      let v_9 = select(vec2<f32>(), vec2<f32>(0.0f, 1.0f), vec2<bool>(v_7, v_7));
      v_5 = v_8;
      v_6 = v_9;
    }
    let v_10 = v_6;
    v_3 = v_5;
    v_4 = v_10;
  }
  let v_11 = v_4;
  v = v_3;
  v_1 = vec4<f32>(v_11.x, v_11.y, 0.0f, 1.0f);
}

struct tint_symbol_1 {
  @location(0u)
  m : vec4<f32>,
  @builtin(position)
  tint_symbol : vec4<f32>,
}

@vertex
fn main(@builtin(vertex_index) v_12 : u32) -> tint_symbol_1 {
  main_inner(v_12);
  return tint_symbol_1(v, v_1);
}
