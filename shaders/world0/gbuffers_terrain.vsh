#version 120

#include "/lib/defines.glsl"
#include "/lib/colors.glsl"
#include "/lib/wave.glsl"

attribute vec2 mc_midTexCoord;
attribute vec4 mc_Entity;

uniform float frameTimeCounter;
uniform float rainStrength;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 tint;

void main() {
  lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
  texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
  tint = gl_Color;

  vec3 vPosView = (gl_ModelViewMatrix * gl_Vertex).xyz;
  vec3 vPosPlayer = mat3(gbufferModelViewInverse) * vPosView;
  vec3 worldPos = vPosPlayer + cameraPosition;
  vec3 offset = vec3(0.0);

  if (mc_Entity.x > 10000) {
    int id = int(mc_Entity) - 10000;

    if (id == 1) {
      float amount = float(texcoord.y < mc_midTexCoord.y);
      offset.xz += wave(
        frameTimeCounter,
        worldPos,
        BLOCKS_GRASS_WAVE_SPEED / 10.0,
        2.0 * lmcoord.y * (rainStrength + 1.0) * (BLOCKS_GRASS_WAVE_STRENGTH / 10.0)
      ) * amount;
    } else
    if (id == 2) {
      float amount = float(texcoord.y < mc_midTexCoord.y) + 1.0;
      offset.xz += wave(
        frameTimeCounter,
        worldPos,
        BLOCKS_GRASS_WAVE_SPEED / 10.0,
        2.0 * lmcoord.y * (rainStrength + 1.0) * (BLOCKS_GRASS_WAVE_STRENGTH / 10.0)
      ) * amount;
    } else
    if (id == 10) {
      if (BLOCKS_LEAVES_WAVE_SPEED != 0.0 && BLOCKS_LEAVES_WAVE_STRENGTH != 0.0) {
        offset.xz += wave(
          frameTimeCounter,
          worldPos,
          BLOCKS_LEAVES_WAVE_SPEED / 10.0,
          2.0 * lmcoord.y * (rainStrength + 1.0) * (BLOCKS_LEAVES_WAVE_STRENGTH / 10.0)
        );
      }
    } else
    if (id == 20) {
      if (BLOCKS_WATER_WAVE_SPEED != 0 && BLOCKS_WATER_WAVE_STRENGTH != 0) {
        float aboveSeaLevel = worldPos.y - (BLOCKS_WATER_SEA_LEVEL - 1.0);
        if (0.0 < aboveSeaLevel && aboveSeaLevel <= 1.0) {
          offset.y +=
            sin(frameTimeCounter * 4.0 * (BLOCKS_WATER_WAVE_SPEED / 10.0) + worldPos.x + worldPos.z)
            / 8.0 * (rainStrength + 1.0) * BLOCKS_WATER_WAVE_STRENGTH / 10.0
            * aboveSeaLevel;
        }
      }
    }
  }

  gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(worldPos + offset - cameraPosition, 1.0);
}
