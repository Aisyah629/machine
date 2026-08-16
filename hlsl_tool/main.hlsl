// main.hlsl
// High-Level Shader Language (HLSL) Application
// Objective: High-performance graphics shader development and real-time visual simulation.

// Define a structure for the input vertices
struct VS_INPUT
{
    float4 Position : POSITION;
    float2 UV : TEXCOORD0;
    float3 Normal : NORMAL;
};

// Define a structure for the output vertices (passing to pixel shader)
struct PS_INPUT
{
    float4 Position : SV_POSITION;
    float2 UV : TEXCOORD0;
    float3 Normal : TEXCOORD1;
};

// Uniform variables passed from the host application
cbuffer MatrixBuffer : register(b0)
{
    float4x4 WorldMatrix;
    float4x4 ViewMatrix;
    float4x4 ProjectionMatrix;
    float4 AmbientLight;
};

cbuffer TimeBuffer : register(b1)
{
    float Time;
    float DeltaTime;
};

// Vertex Shader: Transforms input vertices to clip space and passes UV/Normal data
PS_INPUT VS(VS_INPUT input)
{
    PS_INPUT output;
    
    // Transform position: World -> View -> Projection
    float4 worldPos = mul(input.Position, WorldMatrix);
    float4 viewPos = mul(worldPos, ViewMatrix);
    output.Position = mul(viewPos, ProjectionMatrix);
    
    // Pass UV coordinates
    output.UV = input.UV;
    
    // Transform normal (approximate, assuming uniform scale for simplicity)
    output.Normal = mul((float3x3)WorldMatrix, input.Normal);
    
    return output;
}

// Pixel Shader: Calculates final color based on lighting and texture
float4 PS(PS_INPUT input) : SV_TARGET
{
    // Simple lighting calculation
    float3 lightDirection = normalize(float3(0.5, 1.0, 0.3));
    float3 normal = normalize(input.Normal);
    
    // Diffuse lighting
    float diff = max(dot(normal, lightDirection), 0.0);
    
    // Ambient lighting
    float3 ambient = AmbientLight.rgb;
    
    // Combine lighting
    float3 finalColor = (ambient + diff) * 0.8; // 0.8 is a placeholder for object albedo
    
    // Add a subtle time-based animation effect
    finalColor += sin(Time * 2.0) * 0.1;
    
    return float4(finalColor, 1.0);
}

// Compute Shader Example: Simulating particle movement or data processing
// This is a placeholder for a compute shader entry point
[numthreads(8, 8, 1)]
void CS_Main(uint3 id : SV_DispatchThreadID)
{
    // Placeholder for compute logic
    // Example: id.x, id.y, id.z could represent indices in a structured buffer
    // performing parallel operations on the GPU.
}
