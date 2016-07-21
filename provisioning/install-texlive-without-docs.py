# from my script
#   https://gist.github.com/briandk/924d101f28dbf309758206fa3eff32b4
import subprocess

get_line_by_line_texlive_dependencies = subprocess.run(
    [
        "apt-cache",
        "depends",
        "texlive-full"
    ],
    universal_newlines=True,
    stdout=subprocess.PIPE
)

def extract_dependency(dependency_text, pattern="Depends: "):
    dependency = dependency_text.strip().replace(pattern, "")
    return(dependency)

dependencies = [
    extract_dependency(line)
        for line in get_line_by_line_texlive_dependencies.stdout.splitlines()
            if line.strip().startswith(pattern) and not line.strip().endswith("-doc")]


arguments = [
    "apt-get",
    "install",
    "--assume-yes",
    "--no-install-recommends"
]

arguments.extend(dependencies)

# execute apt-get install with all the package names
# subprocess.run(arguments)
