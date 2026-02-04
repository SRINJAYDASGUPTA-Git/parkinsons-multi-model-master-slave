import os

SUBDIRS = [
    "data/raw",
    "data/processed",
    "data/interim",
    "features",
    "models",
    "notebooks",
    "utils"
]

created = []
skipped = []
gitkeeps = []

for sub in SUBDIRS:
    # Create directory if not exists
    if not os.path.exists(sub):
        try:
            os.makedirs(sub)
            created.append(sub)
        except Exception as e:
            print(f"Failed to create {sub}: {e}")
            continue
    else:
        skipped.append(sub)

    # Create .gitkeep file inside each directory
    gitkeep_path = os.path.join(sub, ".gitkeep")
    if not os.path.exists(gitkeep_path):
        try:
            open(gitkeep_path, "w").close()   # create empty file
            gitkeeps.append(gitkeep_path)
        except Exception as e:
            print(f"Failed to create {gitkeep_path}: {e}")

print("\nDirectory summary:")
if created:
    print("Created directories:")
    for d in created:
        print(f" - {d}")

if skipped:
    print("Skipped existing directories:")
    for d in skipped:
        print(f" - {d}")

if gitkeeps:
    print("\nCreated .gitkeep files:")
    for g in gitkeeps:
        print(f" - {g}")
