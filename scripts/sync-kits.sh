#!/usr/bin/env bash
# Regenerates the EDS and AEP/AJO skills from their Claude kit repos: rewrites paths/commands for this hub
# and applies the local scrub rules in scripts/.scrub-names (git-ignored, so names never get published).
set -euo pipefail

HUB="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS="$HUB/.github/skills"
EDS_KIT="${EDS_KIT:-$HUB/../eds-enablement-training-kit}"
AEP_KIT="${AEP_KIT:-$HUB/../adobe-aep-ajo-training-kit}"
export SCRUB_FILE="$HUB/scripts/.scrub-names"

[[ -f "$SCRUB_FILE" ]] || echo "WARNING: $SCRUB_FILE not found — project names will NOT be scrubbed." >&2

sync_kit() {
  local kit="$1" dest="$SKILLS/$2"
  [[ -f "$kit/skill/SKILL.md" ]] || { echo "Not found: $kit/skill/SKILL.md (set EDS_KIT / AEP_KIT)"; exit 1; }
  mkdir -p "$dest/program"
  # the kit's training/ folder becomes program/ inside the skill
  rsync -a --delete --exclude .DS_Store --exclude program "$kit/skill/" "$dest/"
  rsync -a --delete --exclude .DS_Store --exclude .idea "$kit/training/" "$dest/program/"
  echo "synced  $2  <-  $kit"
}

sync_kit "$EDS_KIT" eds-enablement-masterclass
sync_kit "$AEP_KIT" adobe-experience-masterclass

find "$SKILLS/eds-enablement-masterclass" "$SKILLS/adobe-experience-masterclass" -name '*.md' -print0 |
  xargs -0 perl -0pi -e '
    BEGIN {
      %cmd = (
        "eds-enablement" => "/enablement eds", "eds-learn" => "/learn eds", "eds-explain" => "/define eds",
        "eds-quiz" => "/quiz eds", "eds-simulate" => "/simulate eds",
        "adobe-training" => "/enablement aep", "aep-learn" => "/learn aep", "aep-explain" => "/define aep",
        "aep-quiz" => "/quiz aep", "aep-simulate" => "/simulate aep",
        "aep" => "/learn aep", "ajo" => "/learn ajo", "cja" => "/learn cja", "rtcdp" => "/learn rtcdp",
      );
      # .scrub-names lines: "find|replace", "find|" (block only, see check-names.sh), or "section:<heading>"
      if (open my $fh, "<", $ENV{SCRUB_FILE}) {
        local $/ = "\n";
        while (<$fh>) {
          chomp;
          next if /^\s*(#|$)/;
          if (/^section:(.+)$/) { push @sections, $1; next }
          my ($find, $repl) = split /\|/, $_, 2;
          push @rules, [$find, $repl] if length($repl // "");
        }
      }
    }
    for my $h (@sections) { s/^\Q$h\E.*?(?=^## |\z)//msg }
    s{\.\./skill/}{../}g;
    s{\.\./training/}{program/}g;
    s{`~/projects/Adobe Training/`}{`program/`}g;
    s{~/(?:eds-enablement-training|adobe-training)/}{program/}g;
    s{(?<=[\s`(\[])/(eds-enablement|eds-learn|eds-explain|eds-quiz|eds-simulate|adobe-training|aep-learn|aep-explain|aep-quiz|aep-simulate|aep|ajo|cja|rtcdp)(?![\w-])}{$cmd{$1}}g;
    for my $r (@rules) { my ($f, $t) = @$r; s/\Q$f\E/$t/g }
  '

# Copilot skill frontmatter only needs name + description
for f in "$SKILLS"/{eds-enablement-masterclass,adobe-experience-masterclass}/SKILL.md; do
  perl -0pi -e 's{\A(---\n.*?\n---\n)}{ my $fm = $1; $fm =~ s/^(?:display_name|category|version|status):.*\n//mg; $fm =~ s/^(?:keywords|related_skills):\n(?:  - .*\n)*//mg; $fm }se' "$f"
done

"$HUB/scripts/check-names.sh"
