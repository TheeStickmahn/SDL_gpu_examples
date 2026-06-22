struct S {
  mode : i32,
}

@group(3u) @binding(0u) var<uniform> UBO : S;

@group(2u) @binding(0u) var Texture : texture_2d<f32>;

var<private> v : vec4<f32>;

fn main_inner(v_1 : vec2<f32>) {
  var v_2 : vec4<f32>;
  switch(0u) {
    default: {
      let v_3 = textureDimensions(Texture, 0i);
      let v_4 = vec2<i32>((vec2<f32>(f32(v_3.x), f32(v_3.y)) * v_1));
      let v_5 = bitcast<vec2<u32>>(v_4);
      let v_6 = textureLoad(Texture, v_5, i32(0u));
      if ((UBO.mode == 0i)) {
        v_2 = v_6;
        break;
      } else {
        let v_7 = bitcast<vec2<u32>>((v_4 + vec2<i32>(0i, 1i)));
        let v_8 = textureLoad(Texture, v_7, i32(0u));
        let v_9 = bitcast<vec2<u32>>((v_4 + vec2<i32>(-1i, 0i)));
        let v_10 = textureLoad(Texture, v_9, i32(0u));
        let v_11 = bitcast<vec2<u32>>((v_4 + vec2<i32>(0i, -1i)));
        let v_12 = textureLoad(Texture, v_11, i32(0u));
        let v_13 = bitcast<vec2<u32>>((v_4 + vec2<i32>(1i, 0i)));
        v_2 = (((((v_6 * 0.20000000298023223877f) + (v_8 * 0.20000000298023223877f)) + (v_10 * 0.20000000298023223877f)) + (v_12 * 0.20000000298023223877f)) + (textureLoad(Texture, v_13, i32(0u)) * 0.20000000298023223877f));
        break;
      }
    }
  }
  v = v_2;
}

@fragment
fn main(@location(0u) v_14 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_14);
  return v;
}
