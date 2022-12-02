// Made with Amplify Shader Editor v1.9.1.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JCity/NieR/NierStandardCutout"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("_MainTex", 2D) = "white" {}
		_BumpMap("_BumpMap", 2D) = "bump" {}
		_ORM("_ORM", 2D) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _ORM;
		uniform float4 _ORM_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode6 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 appendResult89 = (float3(tex2DNode6.r , tex2DNode6.g , tex2DNode6.b));
			float3 Normal28 = appendResult89;
			o.Normal = Normal28;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
			float4 Diffuse19 = tex2DNode2;
			o.Albedo = Diffuse19.rgb;
			float2 uv_ORM = i.uv_texcoord * _ORM_ST.xy + _ORM_ST.zw;
			float4 tex2DNode9 = tex2D( _ORM, uv_ORM );
			float Metallic98 = tex2DNode9.b;
			o.Metallic = Metallic98;
			float Roughness97 = ( 1.0 - tex2DNode9.g );
			o.Smoothness = Roughness97;
			o.Alpha = 1;
			float Alpha100 = tex2DNode2.a;
			clip( Alpha100 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19102
Node;AmplifyShaderEditor.CommentaryNode;41;-1663.498,1217.927;Inherit;False;1480.765;701.0444;Comment;5;9;36;97;98;96;ORM;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1665.792,451.0248;Inherit;False;1487.901;740.3632;Comment;4;28;6;89;90;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1658.852,-272.3438;Inherit;False;1549.753;708.6382;Comment;3;19;2;100;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-154.932,-842.8796;Inherit;False;19;Diffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1531.091,-139.1549;Inherit;True;Property;_MainTex;_MainTex;1;0;Create;True;0;0;0;False;0;False;-1;None;f390e4df48dd3174a99969caa0ed4cb5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1615.792,501.0248;Inherit;True;Property;_BumpMap;_BumpMap;2;0;Create;True;0;0;0;False;0;False;-1;None;13cc473228757814295076e405213922;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-581.2446,529.6592;Inherit;True;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;90;-1190.717,559.2805;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;89;-893.6126,533.0856;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;9;-1627.237,1265.179;Inherit;True;Property;_ORM;_ORM;3;0;Create;True;0;0;0;False;0;False;-1;None;9f2f8cd132c2e064881f9af0eef68e49;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;42;-392.8505,-793.9297;Inherit;False;28;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-518.1851,1284.626;Inherit;True;ORM;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;96;-776.9101,1477.8;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;98;-871.7826,1629.755;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;97;-582.7826,1544.755;Inherit;False;Roughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-50.1853,-709.5203;Inherit;False;98;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1152.48,-124.5606;Inherit;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-1126.302,17.75671;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-52.57281,-632.7539;Inherit;False;97;Roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-54.30225,-510.2433;Inherit;False;100;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;208.6983,-813.0403;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;JCity/NieR/NierStandardCutout;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;89;0
WireConnection;90;0;6;2
WireConnection;89;0;6;1
WireConnection;89;1;6;2
WireConnection;89;2;6;3
WireConnection;36;0;9;0
WireConnection;96;0;9;2
WireConnection;98;0;9;3
WireConnection;97;0;96;0
WireConnection;19;0;2;0
WireConnection;100;0;2;4
WireConnection;0;0;18;0
WireConnection;0;1;42;0
WireConnection;0;3;99;0
WireConnection;0;4;45;0
WireConnection;0;10;101;0
ASEEND*/
//CHKSM=28F49CC278C9718B1E99CD7B43569C4D0732CB31