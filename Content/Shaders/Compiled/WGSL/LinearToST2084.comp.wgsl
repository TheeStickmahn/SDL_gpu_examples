@group(0u) @binding(0u) var InImage : texture_2d<f32>;

@group(1u) @binding(0u) var OutImage : texture_storage_2d<rgba8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(bitcast<vec2<i32>>(v.xy));
  let v_2 = textureLoad(InImage, v_1, i32(0u));
  let v_3 = pow(abs((((v_2.xyz * mat3x3<f32>(vec3<f32>(0.62740397453308105469f, 0.32928198575973510742f, 0.04331360012292861938f), vec3<f32>(0.06909699738025665283f, 0.91953998804092407227f, 0.01136120036244392395f), vec3<f32>(0.01639159955084323883f, 0.08801320195198059082f, 0.89559501409530639648f))) * 200.0f) * vec3<f32>(0.00009999999747378752f))), vec3<f32>(0.1593017578125f));
  let v_4 = pow(((vec3<f32>(0.8359375f) + (v_3 * 18.8515625f)) / (vec3<f32>(1.0f) + (v_3 * 18.6875f))), vec3<f32>(78.84375f));
  textureStore(OutImage, v_1, vec4<f32>(v_4.x, v_4.y, v_4.z, v_2.w));
}
