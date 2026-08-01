# Typst build workflow for the report (replaces compile.zsh / watch.zsh /
# clear_aux.zsh / log.zsh / init.zsh / usercmd.zsh, and .latexmkrc, which
# drove the LaTeX build and are no longer needed now that the report is
# authored directly in Typst — see main.typ).

entry := "main.typ"
# Deliberately not out/rapport.pdf: that path is the pre-existing, git-tracked
# LaTeX build's compiled output (see out/'s history) and is left untouched.
out := "out/rapport-typst.pdf"

# List available recipes.
default:
    @just --list

# Compile the report to {{out}}.
compile:
    typst compile {{entry}} {{out}}

# Compile without keeping the PDF — a fast correctness check for CI.
check:
    typst compile --format pdf {{entry}} /dev/null

# Recompile automatically whenever a source file changes.
watch:
    typst watch {{entry}} {{out}}

# Open the compiled PDF in the system's default viewer.
preview: compile
    #!/usr/bin/env sh
    set -eu
    if command -v xdg-open >/dev/null; then xdg-open {{out}}
    elif command -v open >/dev/null; then open {{out}}
    else echo "no opener found (xdg-open/open); compiled PDF is at {{out}}"; fi

# List bibliography.yml entries that are never #cite()'d from content/.
check-bibliography:
    #!/usr/bin/env sh
    set -eu
    unused=0
    for key in $(grep -oE '^[A-Za-z0-9_.:-]+:' bibliography.yml | sed 's/:$//'); do
        if ! grep -qrF -e "<${key}>" -e "label(\"${key}\")" -e "@${key}" content/; then
            echo "unused bibliography entry: ${key}"
            unused=1
        fi
    done
    if [ "$unused" -eq 0 ]; then echo "all bibliography.yml entries are cited"; fi

# Remove compiled output.
clean:
    rm -f {{out}}

# Show this help (alias for the default recipe).
help:
    @just --list
