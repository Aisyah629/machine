// HLSL Example Tool
// This file demonstrates a basic vertex and pixel shader pipeline.

struct VSInput {
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

struct PSInput {
    float4 Position : SV_POSITION;
    float2 TexCoord : TEXCOORD0;
};

PSInput VSMain(VSInput input) {
    PSInput output;
    // Transform position to clip space
    output.Position = input.Position;
    // Pass through texture coordinates
    output.TexCoord = input.TexCoord;
    return output;
}

float4 PSMain(PSInput input) : SV_TARGET {
    // Return a solid color (white in this example)
    return float4(1.0, 1.0, 1.0, 1.0);
}

// Technique to bundle the shaders
technique10 Technique1 {
    pass P0 {
        SetVertexShader(CompileShader(vs_4_0, VSMain()));
        SetGeometryShader(NULL);
        SetPixelShader(CompileShader(ps_4_0, PSMain()));
    }
}
