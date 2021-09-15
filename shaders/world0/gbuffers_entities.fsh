#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec4 entityColor;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 tint;

void main() {
  vec4 color = texture2D(texture, texcoord);
  color *= tint;
  color *= texture2D(lightmap, lmcoord);
  color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);

  gl_FragData[0] = color;
}
