#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"
#include "/lib/fog.glsl"

uniform int isEyeInWater;
uniform mat4 gbufferProjectionInverse;
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform vec3 cameraPosition;
uniform vec3 fogColor;

varying vec2 texcoord;

void main() {
	vec4 color = texture2D(colortex0, texcoord);
  float depth = texture2D(depthtex0, texcoord).r;

  if (depth == 1.0) { // sky
    gl_FragData[0] = color;
  } else {
    vec3 screen = vec3(texcoord, depth) * 2.0 - 1.0;
    vec4 tmp = gbufferProjectionInverse * vec4(screen, 1.0);
    vec3 view = tmp.xyz / tmp.w;
    float vertexDistance = length(view);

    if (isEyeInWater == 0) {
      #ifdef FOG_OVERWORLD_ENABLED
        gl_FragData[0] = fog(
          color,
          vertexDistance,
          FOG_OVERWORLD_START,
          FOG_OVERWORLD_END,
          vec4(fogColor, color.a)
        );
      #else
        gl_FragData[0] = color;
      #endif
    } else
    if (isEyeInWater == 1) {
      #ifdef FOG_WATER_ENABLED
        gl_FragData[0] = fog(
          color,
          vertexDistance,
          FOG_WATER_START,
          FOG_WATER_END,
          vec4(fogColor, color.a)
        );
      #else
        gl_FragData[0] = color;
      #endif
    } else
    if (isEyeInWater == 2) {
      #ifdef FOG_LAVA_ENABLED
        gl_FragData[0] = fog(
          color,
          vertexDistance,
          FOG_LAVA_START,
          FOG_LAVA_END,
          vec4(FOG_LAVA_COLOR, color.a)
        );
      #else
        gl_FragData[0] = color;
      #endif
    }
  }
}
