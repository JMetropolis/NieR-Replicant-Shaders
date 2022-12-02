// Made with Amplify Shader Editor v1.9.1.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JCity/NieR/NierMultiUVBlend"
{
	Properties
	{
		_MultiUV("MultiUV", 2D) = "white" {}
		_MainTex("Base layer - Diffuse", 2D) = "white" {}
		_BumpMap("Base Layer - Normal", 2D) = "bump" {}
		_BaseLayerORM("Base Layer - ORM", 2D) = "white" {}
		_Layer1Diffuse("Layer 1 - Diffuse", 2D) = "white" {}
		_Layer1Normal("Layer 1 - Normal", 2D) = "bump" {}
		_Layer1ORM("Layer 1 - ORM", 2D) = "white" {}
		_Layer2Diffuse("Layer 2 - Diffuse", 2D) = "white" {}
		_Layer2Normal("Layer 2 - Normal", 2D) = "bump" {}
		_Layer2ORM("Layer 2 - ORM", 2D) = "white" {}
		_Layer3Diffuse("Layer 3 - Diffuse", 2D) = "white" {}
		_Layer3Normal("Layer 3 - Normal", 2D) = "bump" {}
		_Layer3ORM("Layer 3 - ORM", 2D) = "white" {}
		_Metallic("Metallic", Float) = 1
		_Roughness("Roughness", Float) = 1
		_Occlusion("Occlusion", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv2_texcoord2;
			float2 uv_texcoord;
		};

		uniform sampler2D _MultiUV;
		uniform float4 _MultiUV_ST;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _Layer1Normal;
		uniform float4 _Layer1Normal_ST;
		uniform sampler2D _Layer2Normal;
		uniform float4 _Layer2Normal_ST;
		uniform sampler2D _Layer3Normal;
		uniform float4 _Layer3Normal_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _Layer1Diffuse;
		uniform float4 _Layer1Diffuse_ST;
		uniform sampler2D _Layer2Diffuse;
		uniform float4 _Layer2Diffuse_ST;
		uniform sampler2D _Layer3Diffuse;
		uniform float4 _Layer3Diffuse_ST;
		uniform sampler2D _BaseLayerORM;
		uniform float4 _BaseLayerORM_ST;
		uniform sampler2D _Layer1ORM;
		uniform float4 _Layer1ORM_ST;
		uniform sampler2D _Layer2ORM;
		uniform float4 _Layer2ORM_ST;
		uniform sampler2D _Layer3ORM;
		uniform float4 _Layer3ORM_ST;
		uniform float _Metallic;
		uniform float _Roughness;
		uniform float _Occlusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv1_MultiUV = i.uv2_texcoord2 * _MultiUV_ST.xy + _MultiUV_ST.zw;
			float4 tex2DNode1 = tex2D( _MultiUV, uv1_MultiUV );
			float4 break111 = tex2DNode1;
			float3 appendResult112 = (float3(break111.r , break111.g , break111.b));
			float3 MultiUV50 = saturate( appendResult112 );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv_Layer1Normal = i.uv_texcoord * _Layer1Normal_ST.xy + _Layer1Normal_ST.zw;
			float2 uv_Layer2Normal = i.uv_texcoord * _Layer2Normal_ST.xy + _Layer2Normal_ST.zw;
			float2 uv_Layer3Normal = i.uv_texcoord * _Layer3Normal_ST.xy + _Layer3Normal_ST.zw;
			float3 layeredBlendVar137 = MultiUV50;
			float3 layeredBlend137 = ( lerp( lerp( lerp( UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) ) , UnpackNormal( tex2D( _Layer1Normal, uv_Layer1Normal ) ) , layeredBlendVar137.x ) , UnpackNormal( tex2D( _Layer2Normal, uv_Layer2Normal ) ) , layeredBlendVar137.y ) , UnpackNormal( tex2D( _Layer3Normal, uv_Layer3Normal ) ) , layeredBlendVar137.z ) );
			float3 Normal28 = layeredBlend137;
			o.Normal = Normal28;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 uv_Layer1Diffuse = i.uv_texcoord * _Layer1Diffuse_ST.xy + _Layer1Diffuse_ST.zw;
			float2 uv_Layer2Diffuse = i.uv_texcoord * _Layer2Diffuse_ST.xy + _Layer2Diffuse_ST.zw;
			float2 uv_Layer3Diffuse = i.uv_texcoord * _Layer3Diffuse_ST.xy + _Layer3Diffuse_ST.zw;
			float3 layeredBlendVar124 = MultiUV50;
			float4 layeredBlend124 = ( lerp( lerp( lerp( tex2D( _MainTex, uv_MainTex ) , tex2D( _Layer1Diffuse, uv_Layer1Diffuse ) , layeredBlendVar124.x ) , tex2D( _Layer2Diffuse, uv_Layer2Diffuse ) , layeredBlendVar124.y ) , tex2D( _Layer3Diffuse, uv_Layer3Diffuse ) , layeredBlendVar124.z ) );
			float4 Diffuse19 = layeredBlend124;
			o.Albedo = Diffuse19.rgb;
			float2 uv_BaseLayerORM = i.uv_texcoord * _BaseLayerORM_ST.xy + _BaseLayerORM_ST.zw;
			float2 uv_Layer1ORM = i.uv_texcoord * _Layer1ORM_ST.xy + _Layer1ORM_ST.zw;
			float2 uv_Layer2ORM = i.uv_texcoord * _Layer2ORM_ST.xy + _Layer2ORM_ST.zw;
			float2 uv_Layer3ORM = i.uv_texcoord * _Layer3ORM_ST.xy + _Layer3ORM_ST.zw;
			float3 layeredBlendVar138 = MultiUV50;
			float4 layeredBlend138 = ( lerp( lerp( lerp( tex2D( _BaseLayerORM, uv_BaseLayerORM ) , tex2D( _Layer1ORM, uv_Layer1ORM ) , layeredBlendVar138.x ) , tex2D( _Layer2ORM, uv_Layer2ORM ) , layeredBlendVar138.y ) , tex2D( _Layer3ORM, uv_Layer3ORM ) , layeredBlendVar138.z ) );
			float4 break108 = layeredBlend138;
			float Metallic106 = break108.b;
			o.Metallic = pow( Metallic106 , _Metallic );
			float Roughness105 = ( 1.0 - break108.g );
			o.Smoothness = pow( Roughness105 , _Roughness );
			float Occlusion139 = break108.r;
			o.Occlusion = pow( Occlusion139 , _Occlusion );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19102
Node;AmplifyShaderEditor.CommentaryNode;92;-1681.241,-1368.014;Inherit;False;1262.939;531.1483;Comment;7;50;136;1;100;16;15;14;MultiUV;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;41;-1658.643,1569.948;Inherit;False;1536.603;1152.558;Comment;15;59;36;11;10;9;40;104;105;106;108;107;109;138;139;141;ORM;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1672.126,470.0267;Inherit;False;2127.946;1093.229;Comment;12;28;8;7;6;103;137;117;116;91;88;90;51;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1520,-368;Inherit;False;1553.201;908.5822;Comment;9;58;19;2;4;3;102;115;118;124;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1184.433,545.0018;Inherit;False;50;MultiUV;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1166.151,-1138.266;Inherit;False;MultiUV_Red;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-1167.451,-1060.266;Inherit;False;MultiUV_Green;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-1163.253,-983.8659;Inherit;False;MultUV_Blue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-1166.039,-905.3494;Inherit;False;MultUV_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-383.6768,1653.308;Inherit;True;ORM;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-1084.002,1695.867;Inherit;False;50;MultiUV;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WeightedBlendNode;118;-736,224;Inherit;True;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-1631.241,-1213.904;Inherit;True;Property;_MultiUV;MultiUV;0;0;Create;True;0;0;0;False;0;False;-1;None;5bf711cd30deee04ebe7337137f630b1;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-192,-48;Inherit;True;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;111;-1302.049,-1404.453;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WeightedBlendNode;117;-743.6745,1345.566;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;115;-480,240;Inherit;True;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LayeredBlendNode;124;-736,0;Inherit;True;6;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-928,-272;Inherit;True;50;MultiUV;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;2;-1472,-80;Inherit;True;Property;_Layer1Diffuse;Layer 1 - Diffuse;4;0;Create;False;0;0;0;False;0;False;-1;None;bd040f7ef778f0a418cd62fa7394fe2b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1472,112;Inherit;True;Property;_Layer2Diffuse;Layer 2 - Diffuse;7;0;Create;True;0;0;0;False;0;False;-1;None;117a4166eee75e642a55f8305415b47e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1472,304;Inherit;True;Property;_Layer3Diffuse;Layer 3 - Diffuse;10;0;Create;True;0;0;0;False;0;False;-1;None;7ffc452f574871a428b878fb5669984f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;90;-627.052,882.1907;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;88;-307.0515,879.1907;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;91;-465.0515,897.1907;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SummedBlendNode;116;-954.5693,1352.497;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WeightedBlendNode;59;-845.0505,2451.194;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;109;-1044.277,2475.144;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LayeredBlendNode;137;-976.4532,837.2927;Inherit;True;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;104;-1617.396,1749.657;Inherit;True;Property;_BaseLayerORM;Base Layer - ORM;3;0;Create;True;0;0;0;False;0;False;-1;None;a95c25b1e5dc3cf4bb38e5a7da3f4f18;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1619.215,1957.652;Inherit;True;Property;_Layer1ORM;Layer 1 - ORM;6;0;Create;True;0;0;0;False;0;False;-1;None;c7bcb0f11da849e409d3481a1a0ae51f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-1605.476,2149.4;Inherit;True;Property;_Layer2ORM;Layer 2 - ORM;9;0;Create;True;0;0;0;False;0;False;-1;None;b7521c575fdbbf54eace36144aa47d8b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-1605.476,2344.4;Inherit;True;Property;_Layer3ORM;Layer 3 - ORM;12;0;Create;True;0;0;0;False;0;False;-1;None;2b2900f22dd44a846a8b4253cb33235c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LayeredBlendNode;138;-952.0096,1966.493;Inherit;True;6;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;108;-633.7947,2009.019;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;67.08835,800.7062;Inherit;True;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-392.4055,2412.455;Inherit;True;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;105;-310.294,2161.179;Inherit;True;Roughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;107;-475.4886,2109.622;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;139;-335.7261,1924.885;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;141;-536.9089,1884.842;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-1625.293,1230.229;Inherit;True;Property;_Layer3Normal;Layer 3 - Normal;11;0;Create;True;0;0;0;False;0;False;-1;None;2d362bfaf13d7a34495471ecfef5ef35;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1625.293,1033.796;Inherit;True;Property;_Layer2Normal;Layer 2 - Normal;8;0;Create;True;0;0;0;False;0;False;-1;None;a3c56f0cc6c9f654e9a805d9c25ae936;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1625.293,831.9766;Inherit;True;Property;_Layer1Normal;Layer 1 - Normal;5;0;Create;False;0;0;0;False;0;False;-1;None;7d48c904067f84144a15331a6430b159;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;103;-1623.231,628.3991;Inherit;True;Property;_BumpMap;Base Layer - Normal;2;0;Create;False;0;0;0;False;0;False;-1;None;0fac7b6e2c1dfbd4086fe5a7e685678d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;102;-1472,-272;Inherit;True;Property;_MainTex;Base layer - Diffuse;1;0;Create;False;0;0;0;False;0;False;-1;None;5518d85c18e8f9b4aa15533e2ca8d098;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;18;121.8427,-1181.857;Inherit;False;19;Diffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;89.84277,-1101.857;Inherit;False;28;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-6.157239,-909.8574;Inherit;False;105;Roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;136;-788.7778,-1264.059;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;112;-1059.049,-1348.453;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-625.302,-1290.077;Inherit;True;MultiUV;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;640.8427,-1035.857;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;JCity/NieR/NierMultiUVBlend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;154.8427,-792.8573;Inherit;False;139;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-150.1572,-1037.857;Inherit;False;106;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;149;434.8271,-780.1295;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;150;87.82715,-609.1295;Inherit;False;Property;_Occlusion;Occlusion;15;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;152;-241.1729,-962.1295;Inherit;False;Property;_Metallic;Metallic;13;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-140.1729,-801.1295;Inherit;False;Property;_Roughness;Roughness;14;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;153;236.8271,-906.1295;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;154;95.82715,-1018.13;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
WireConnection;14;0;1;1
WireConnection;15;0;1;2
WireConnection;16;0;1;3
WireConnection;36;0;138;0
WireConnection;19;0;124;0
WireConnection;111;0;1;0
WireConnection;124;0;58;0
WireConnection;124;1;102;0
WireConnection;124;2;2;0
WireConnection;124;3;3;0
WireConnection;124;4;4;0
WireConnection;90;0;137;0
WireConnection;88;0;90;0
WireConnection;88;1;91;0
WireConnection;88;2;90;2
WireConnection;91;0;90;1
WireConnection;137;0;51;0
WireConnection;137;1;103;0
WireConnection;137;2;6;0
WireConnection;137;3;7;0
WireConnection;137;4;8;0
WireConnection;138;0;40;0
WireConnection;138;1;104;0
WireConnection;138;2;9;0
WireConnection;138;3;10;0
WireConnection;138;4;11;0
WireConnection;108;0;138;0
WireConnection;28;0;137;0
WireConnection;106;0;108;2
WireConnection;105;0;107;0
WireConnection;107;0;108;1
WireConnection;139;0;108;0
WireConnection;136;0;112;0
WireConnection;112;0;111;0
WireConnection;112;1;111;1
WireConnection;112;2;111;2
WireConnection;50;0;136;0
WireConnection;0;0;18;0
WireConnection;0;1;42;0
WireConnection;0;3;154;0
WireConnection;0;4;153;0
WireConnection;0;5;149;0
WireConnection;149;0;140;0
WireConnection;149;1;150;0
WireConnection;153;0;45;0
WireConnection;153;1;151;0
WireConnection;154;0;101;0
WireConnection;154;1;152;0
ASEEND*/
//CHKSM=770EA321551F1C0825F6B9F3D257F62F97B76F5F