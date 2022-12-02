// Made with Amplify Shader Editor v1.9.1.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JCity/NierFoliage"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_MainTex("_MainTex", 2D) = "white" {}
		_BumpMap("_BumpMap", 2D) = "bump" {}
		_ORM("_ORM", 2D) = "black" {}
		_WindNoise("WindNoise", 2D) = "white" {}
		_EnableTranslucency("Enable Translucency", Float) = 1
		_WindJitter("Wind Jitter", Float) = 0.1
		_WindScroll("Wind Scroll", Float) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TreeTransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Translucency;
		};

		uniform sampler2D _WindNoise;
		uniform float _WindScroll;
		uniform float _WindJitter;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _ORM;
		uniform float4 _ORM_ST;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float _EnableTranslucency;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult111 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_112_0 = ( appendResult111 * 0.1 );
			float2 panner116 = ( ( _WindScroll * _Time.y ) * float2( 1,1 ) + temp_output_112_0);
			float4 saferPower124 = abs( tex2Dlod( _WindNoise, float4( panner116, 0, 0.0) ) );
			float2 panner126 = ( ( _Time.y * _WindJitter ) * float2( 1,1 ) + ( temp_output_112_0 * float2( 2,2 ) ));
			float4 Wind121 = ( ( pow( saferPower124 , 0.1 ) * tex2Dlod( _WindNoise, float4( panner126, 0, 0.0) ) ) / 100.0 );
			v.vertex.xyz += Wind121.rgb;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !defined(DIRECTIONAL)
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode6 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 Normal28 = tex2DNode6;
			o.Normal = Normal28;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
			float4 Diffuse19 = tex2DNode2;
			o.Albedo = Diffuse19.rgb;
			float2 uv_ORM = i.uv_texcoord * _ORM_ST.xy + _ORM_ST.zw;
			float4 break135 = tex2D( _ORM, uv_ORM );
			float Metallic138 = break135.b;
			o.Metallic = Metallic138;
			float Roughness36 = ( 1.0 - break135.g );
			o.Smoothness = Roughness36;
			float3 temp_cast_1 = (_EnableTranslucency).xxx;
			o.Translucency = temp_cast_1;
			o.Alpha = 1;
			float Alpha95 = tex2DNode2.a;
			clip( Alpha95 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19102
Node;AmplifyShaderEditor.CommentaryNode;122;-2732.793,-1314.564;Inherit;False;1995.863;914.2776;Comment;19;127;115;126;125;116;124;121;113;111;120;119;118;112;110;129;128;130;132;133;Wind;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;41;-1663.498,1217.927;Inherit;False;1480.765;701.0444;Comment;5;9;36;135;136;138;ORM;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1665.792,451.0248;Inherit;False;1487.901;740.3632;Comment;5;28;6;89;90;99;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1658.852,-272.3438;Inherit;False;1549.753;708.6382;Comment;3;19;2;95;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;2;-1531.091,-139.1549;Inherit;True;Property;_MainTex;_MainTex;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1615.792,501.0248;Inherit;True;Property;_BumpMap;_BumpMap;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1627.237,1265.179;Inherit;True;Property;_ORM;_ORM;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-1125.847,13.54285;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-808.2446,503.6592;Inherit;True;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;89;-1005.613,595.0856;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;90;-1208.717,608.2805;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;98;-1195.606,702.7068;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;99;-1090.606,572.7068;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1152.48,-124.5606;Inherit;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;110;-2682.793,-1233.24;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-2255.636,-1212.211;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;118;-2636.291,-799.5273;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-2378.291,-873.5273;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;111;-2421.591,-1216.04;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2499.636,-1038.211;Inherit;False;Constant;_NoiseSize;Noise Size;13;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;116;-2082.635,-1189.211;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-2108.141,-906.4978;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;2,2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;126;-1951.141,-898.4978;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;115;-1870.635,-1257.211;Inherit;True;Property;_WindNoise;WindNoise;11;0;Create;True;0;0;0;False;0;False;-1;a174f25610aa260419d13c28372ca403;a174f25610aa260419d13c28372ca403;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;127;-1720.141,-927.4978;Inherit;True;Property;_Noise1;Noise;11;0;Create;True;0;0;0;False;0;False;-1;a174f25610aa260419d13c28372ca403;a174f25610aa260419d13c28372ca403;True;0;False;white;Auto;False;Instance;115;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;120;-2626.291,-905.5273;Inherit;False;Property;_WindScroll;Wind Scroll;14;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-2201.203,-690.5072;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-2419.203,-633.5072;Inherit;False;Property;_WindJitter;Wind Jitter;13;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;-1243.203,-1193.507;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;208.6983,-813.0403;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;JCity/NierFoliage;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;TreeTransparentCutout;;Transparent;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;1;0;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.PowerNode;124;-1449.141,-1228.498;Inherit;False;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.1;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;135;-1174.622,1446.926;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;136;-1013.114,1437.965;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-682.1851,1366.626;Inherit;True;Roughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;-677.4336,1595.392;Inherit;True;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-960.271,-1149.564;Inherit;False;Wind;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;132;-1088.89,-1132.872;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-1264.89,-937.8718;Inherit;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-14.40869,-432.7802;Inherit;False;121;Wind;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;0.1525879,-519.4572;Inherit;False;95;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;144;-1176.195,-1866.512;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;141;-1525.895,-2039.412;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;145;-969.4949,-1865.212;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-198.932,-995.8796;Inherit;False;19;Diffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-241.4952,-822.6123;Inherit;False;146;PseudoSSS;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-224.7379,-658.143;Inherit;False;36;Roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-228.4095,-729.8952;Inherit;False;138;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-227.2505,-905.6297;Inherit;False;28;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;-585.0951,-1865.112;Inherit;False;PseudoSSS;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NegateNode;148;-1322.907,-1786.177;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;142;-1803.532,-1963.575;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;152;-1537.879,-1755.385;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1773.246,-1672.613;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-1980.176,-1507.07;Inherit;False;Property;_SSSSize;SSS Size;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-775.6412,-1852.073;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;157;-1122.387,-1550.068;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;2;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;153;-2264.928,-1754.267;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformDirectionNode;158;-2057.487,-1722.323;Inherit;False;Object;World;True;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;97;-478.6259,-534.1064;Inherit;False;Property;_EnableTranslucency;Enable Translucency;12;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
WireConnection;95;0;2;4
WireConnection;28;0;6;0
WireConnection;89;0;99;0
WireConnection;89;1;90;0
WireConnection;89;2;98;0
WireConnection;90;0;6;2
WireConnection;98;0;6;3
WireConnection;99;0;6;1
WireConnection;19;0;2;0
WireConnection;112;0;111;0
WireConnection;112;1;113;0
WireConnection;119;0;120;0
WireConnection;119;1;118;0
WireConnection;111;0;110;1
WireConnection;111;1;110;3
WireConnection;116;0;112;0
WireConnection;116;1;119;0
WireConnection;125;0;112;0
WireConnection;126;0;125;0
WireConnection;126;1;128;0
WireConnection;115;1;116;0
WireConnection;127;1;126;0
WireConnection;128;0;118;0
WireConnection;128;1;129;0
WireConnection;130;0;124;0
WireConnection;130;1;127;0
WireConnection;0;0;18;0
WireConnection;0;1;42;0
WireConnection;0;3;45;0
WireConnection;0;4;139;0
WireConnection;0;7;97;0
WireConnection;0;10;96;0
WireConnection;0;11;123;0
WireConnection;124;0;115;0
WireConnection;135;0;9;0
WireConnection;136;0;135;1
WireConnection;36;0;136;0
WireConnection;138;0;135;2
WireConnection;121;0;132;0
WireConnection;132;0;130;0
WireConnection;132;1;133;0
WireConnection;144;0;141;0
WireConnection;144;1;148;0
WireConnection;145;0;144;0
WireConnection;146;0;154;0
WireConnection;148;0;152;0
WireConnection;152;0;142;0
WireConnection;152;1;149;0
WireConnection;149;0;158;0
WireConnection;149;1;150;0
WireConnection;154;0;145;0
WireConnection;154;1;157;0
WireConnection;158;0;153;0
ASEEND*/
//CHKSM=07470CFFF12DAD7E37268CF1E4BD072AFC96F4EA