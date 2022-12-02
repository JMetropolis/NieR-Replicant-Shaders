# NieR:Replicant ver.1.22474487139 Shaders
* A bunch of work in progress shaders created to ease the usage of NieR:Replicant ver.1.22474487139 textures in the Unity engine.
* Made using the Amplify Shader editor.
# Files
## NierStandard
* Basically the standard metallic shader in Unity but which uses the ORM texture to apply occlusion, roughness and metallic.
## NierStandardCutout
* Same as standard but also applies a cutout effect for transparent materials. I will probably depricate this one later and combine it with NierStandard.
## NierMultiUV
* This shader uses the RGBA splat texture to blend 4 different sets of textures.
## NierFoliage
* Simple foliage shader which applies some movement using a noise texture and a configurable subsurface effect.
