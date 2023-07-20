#include "PostEffectTest.hlsli"

Texture2D<float4> tex0 : register(t0); // 0番スロットに設定されたテクスチャ
Texture2D<float4> tex1 : register(t1); // 1番スロットに設定されたテクスチャ

SamplerState smp : register(s0); // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
    float4 texcolorTotal = 0;
    for (float y = -1; y <= 1; y++)
    {
        for (float x = -1; x <= 1; x++)
        {
            texcolorTotal += tex1.Sample(smp, input.uv + float2(x / 640, y / 360));
        }
    }
    texcolorTotal /= 9;

    //return float4(texcolorTotal.rgb, 1);
    
    float4 colortex0 = tex0.Sample(smp, input.uv);
    float4 colortex1 = texcolorTotal;

    float4 color = 1 - colortex0;
    if (fmod(input.uv.y, 0.1f) < 0.05f)
    {
        color = colortex1;
    }

    return float4(color.rgb, 1);
}