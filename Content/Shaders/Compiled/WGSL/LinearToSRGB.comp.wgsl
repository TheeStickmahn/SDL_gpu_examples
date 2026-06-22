@group(0u) @binding(0u) var InImage : texture_2d<f32>;

@group(1u) @binding(0u) var OutImage : texture_storage_2d<rgba8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(bitcast<vec2<i32>>(v.xy));
  let v_2 = pow(abs(textureLoad(InImage, v_1, i32(0u)).xyz), vec3<f32>(0.45454543828964233398f));
  textureStore(OutImage, v_1, vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f));
}
