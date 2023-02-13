Shader "Custom/Fractal01"
{
    Properties {
        _Speed ("Speed", Range(0, 10)) = 1.0
        _Amount ("Amount", Range(0, 1)) = 0.1
    }

    SubShader {
        Tags {"RenderType"="Opaque"}
        LOD 200

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float _Speed;
            float _Amount;

            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target {
                float2 uv = i.uv;
                float4 col = float4(0, 0, 0, 1);
                float noise = _Amount * sin(uv.x * 10 + _Time.y * _Speed) + _Amount * sin(uv.y * 10 + _Time.y * _Speed);
                col.r = noise;
                return col;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
