// Made with Amplify Shader Editor v1.9.1.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JCity/NieR/NierStandard"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "white" {}
		_BumpMap("_BumpMap", 2D) = "bump" {}
		_ORM("_ORM", 2D) = "black" {}
		_Occlusion("Occlusion", Float) = 1
		_Metallic1("Metallic", Float) = 1
		_Roughness("Roughness", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			float2 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _ORM;
		uniform float4 _ORM_ST;
		uniform float _Metallic1;
		uniform float _Roughness;
		uniform float _Occlusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode6 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 Normal28 = tex2DNode6;
			o.Normal = Normal28;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Diffuse19 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = Diffuse19.rgb;
			float2 uv_ORM = i.uv_texcoord * _ORM_ST.xy + _ORM_ST.zw;
			float4 tex2DNode9 = tex2D( _ORM, uv_ORM );
			float Metallic98 = tex2DNode9.b;
			o.Metallic = pow( Metallic98 , _Metallic1 );
			float Roughness97 = ( 1.0 - tex2DNode9.g );
			o.Smoothness = pow( Roughness97 , _Roughness );
			float Occlusion101 = tex2DNode9.r;
			o.Occlusion = pow( Occlusion101 , _Occlusion );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19102
Node;AmplifyShaderEditor.CommentaryNode;41;-1663.498,1217.927;Inherit;False;1480.765;701.0444;Comment;7;9;36;97;98;96;101;102;ORM;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1665.792,451.0248;Inherit;False;1487.901;740.3632;Comment;4;28;6;89;90;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1658.852,-272.3438;Inherit;False;1549.753;708.6382;Comment;2;19;2;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1152.48,-124.5606;Inherit;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1531.091,-139.1549;Inherit;True;Property;_MainTex;_MainTex;0;0;Create;True;0;0;0;False;0;False;-1;None;ab651d5dae727a640b9d9e802ec97d03;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1615.792,501.0248;Inherit;True;Property;_BumpMap;_BumpMap;1;0;Create;True;0;0;0;False;0;False;-1;None;c66e9b96b588d8741b3e9451066ac6fe;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;208.6983,-813.0403;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;JCity/NieR/NierStandard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-518.1851,1284.626;Inherit;True;ORM;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;98;-871.7826,1629.755;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1521.921,1368.796;Inherit;True;Property;_ORM;_ORM;2;0;Create;True;0;0;0;False;0;False;-1;None;1335c071bc0b9f74198e3aad6a5af099;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;97;-582.7826,1544.755;Inherit;False;Roughness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-806.5227,1392.181;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;96;-775.9101,1478.8;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;102;-1025.425,1315.556;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;90;-1176.527,780.2304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;89;-942.2623,737.8203;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;103;-1213.36,846.4674;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;104;-1105.925,720.7896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-691.0339,565.2648;Inherit;True;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-85.93201,-1028.88;Inherit;False;19;Diffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-148.8505,-955.9297;Inherit;False;28;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-303.5728,-724.7539;Inherit;False;97;Roughness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;105;-71.70764,-550.4807;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-650.1853,-987.5203;Inherit;False;98;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;100;-304.8309,-559.975;Inherit;False;101;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-443.7079,-424.4819;Inherit;False;Property;_Occlusion;Occlusion;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;116;-93.70789,-706.4819;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;117;-164.7079,-843.4819;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-478.2079,-683.9819;Inherit;False;Property;_Roughness;Roughness;5;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-688.2079,-840.9819;Inherit;False;Property;_Metallic1;Metallic;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
WireConnection;19;0;2;0
WireConnection;0;0;18;0
WireConnection;0;1;42;0
WireConnection;0;3;117;0
WireConnection;0;4;116;0
WireConnection;0;5;105;0
WireConnection;36;0;9;0
WireConnection;98;0;9;3
WireConnection;97;0;96;0
WireConnection;101;0;9;1
WireConnection;96;0;9;2
WireConnection;90;0;6;2
WireConnection;89;0;104;0
WireConnection;89;1;90;0
WireConnection;89;2;103;0
WireConnection;103;0;6;3
WireConnection;104;0;6;1
WireConnection;28;0;6;0
WireConnection;105;0;100;0
WireConnection;105;1;113;0
WireConnection;116;0;45;0
WireConnection;116;1;115;0
WireConnection;117;0;99;0
WireConnection;117;1;114;0
ASEEND*/
//CHKSM=56110C0E251DFC59FFE1314370DD06C25D25C127