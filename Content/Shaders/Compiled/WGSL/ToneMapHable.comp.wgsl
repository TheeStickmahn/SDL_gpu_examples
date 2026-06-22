@group(0u) @binding(0u) var inImage : texture_2d<f32>;

@group(1u) @binding(0u) var outImage : texture_storage_2d<rgba16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) v : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(bitcast<vec2<i32>>(v.xy));
  let v_2 = (textureLoad(inImage, v_1, i32(0u)).xyz * 2.0f);
  let v_3 = (v_2 * 0.15000000596046447754f);
  let v_4 = (((((v_2 * (v_3 + vec3<f32>(0.05000000074505805969f))) + vec3<f32>(0.00400000018998980522f)) / ((v_2 * (v_3 + vec3<f32>(0.5f))) + vec3<f32>(0.06000000238418579102f))) - vec3<f32>(0.06666666269302368164f)) * vec3<f32>(1.37906432151794433594f));
  textureStore(outImage, v_1, vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f));
}
