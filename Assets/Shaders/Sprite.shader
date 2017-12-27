Shader " Sprites/Default "
{ 
Properties
{
_MainTex ("Base (RGB)", 2D) = "white" {}
_Color ("_Color", Color) = (1,1,1,1)
_Area("Area",Range(0,1)) = 0.5
}

SubShader
{
Tags {"Queue"="Transparent" "IgnoreProjector"="true" "RenderType"="Transparent"}
ZWrite Off Blend SrcAlpha OneMinusSrcAlpha Cull Off

Pass
{

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"

struct appdata_t
{
float4 vertex   : POSITION;
float4 color    : COLOR;
float2 texcoord : TEXCOORD0;
};

struct v2f
{
half2 texcoord  : TEXCOORD0;
float4 vertex   : SV_POSITION;
fixed4 color    : COLOR;
};

sampler2D _MainTex;
float4 _MainTex_ST;
fixed4 _Color;
float _Speed;
float _Area;


v2f vert(appdata_t IN)
{
v2f OUT;
OUT.vertex = UnityObjectToClipPos(IN.vertex);
OUT.texcoord = TRANSFORM_TEX(IN.texcoord,_MainTex);
OUT.color = IN.color;
return OUT;
}

float4 frag (v2f i) : COLOR
{

float2 uv = i.texcoord.xy;
float4 tex = step(tex2D(_MainTex, uv).r,_Area);
return tex;
}
ENDCG
}
}
Fallback "Sprites/Default"

}