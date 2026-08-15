struct VS_INPUT {
    float4 position : POSITION;
    float2 texcoord : TEXCOORD0;
};

struct PS_INPUT {
    float4 position : SV_POSITION;
    float2 texcoord : TEXCOORD0;
};

PS_INPUT vs_main(VS_INPUT input) {
    PS_INPUT output;
    output.position = input.position;
    output.texcoord = input.texcoord;
    return output;
}

float4 ps_main(PS_INPUT input) : SV_TARGET {
    return float4(input.texcoord, 0.0, 1.0);
}
