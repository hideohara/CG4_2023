#include "PostEffectTest.hlsli"

Texture2D<float4> tex : register(t0); // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0); // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
    float4 texcolorTotal = 0;
    for (float y = -1; y <= 1; y++)
    {
        for (float x = -1; x <= 1; x++)
        {
            texcolorTotal += tex.Sample(smp, input.uv + float2(x / 640, y / 360));
        }
    }
    texcolorTotal /= 9;

    return float4(texcolorTotal.rgb, 1);
}