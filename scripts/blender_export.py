# exports currently opened .blend to a .glb using consistent settings
import bpy, sys, os

# read custom args after '--'
argv = sys.argv
outdir = "."
name_override = None
if "--" in argv:
    i = argv.index("--") + 1
    while i < len(argv):
        if argv[i] == "--outdir": outdir = argv[i+1]; i += 2; continue
        if argv[i] == "--name": name_override = argv[i+1]; i += 2; continue
        i += 1

os.makedirs(outdir, exist_ok=True)
# filename from .blend (or override)
blend_path = bpy.data.filepath
base = name_override or os.path.splitext(os.path.basename(blend_path))[0]
out_glb = os.path.join(outdir, f"{base}.glb")

# select everything mesh-like
bpy.ops.object.select_all(action='DESELECT')
for o in bpy.data.objects:
    if o.type in {"MESH","CURVE","SURFACE","META","FONT"}:
        o.select_set(True)

# apply transforms (safe for export preview)
bpy.ops.object.transform_apply(location=False, rotation=True, scale=True)

# export glTF .glb with stable options
bpy.ops.export_scene.gltf(
    filepath=out_glb,
    export_format='GLB',
    use_selection=True,
    export_apply=True,
    export_texcoords=True,
    export_normals=True,
    export_materials='EXPORT',
    export_yup=True
)
print(f"Exported: {out_glb}")
