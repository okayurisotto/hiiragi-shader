#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 tint;

void main() {
  vec4 color = texture2D(texture, texcoord);
  color *= tint;
  // color *= texture2D(lightmap, lmcoord);
  // あえて明るさを無視して光らせる

  gl_FragData[0] = color;
}
