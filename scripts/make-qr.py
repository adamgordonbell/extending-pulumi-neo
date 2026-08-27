import segno
from PIL import Image, ImageDraw, ImageFont
from pathlib import Path

OUT = Path.home()/"sandbox/extending-pulumi-neo/slides/public/img"
VIOLET = "#7e6bff"
MUTED  = "#9aa0ad"

# (filename, url, caption, provisional)
#
# provisional=True renders the hatched PLACEHOLDER treatment so a draft code
# cannot ship by accident. Set it False once the URL is final AND the code has
# been scanned with a real phone.
ITEMS = [
    ("qr-repo.png",       "https://github.com/PLACEHOLDER/extending-pulumi-neo", "repo", True),
    ("qr-blog.png",       "https://www.pulumi.com/blog/10-more-things-you-can-do-with-neo/", "blog post", True),
    ("qr-docs.png",       "https://www.pulumi.com/docs/ai/neo/integrations/", "docs", True),
    ("qr-linkedin.png",   "https://www.linkedin.com/in/adamgordonbell/", "linkedin", True),
    ("qr-emea.png",       "https://www.pulumi.com/events/extending-pulumi-neo-mcp-cloud-cli/", "emea sep 30", True),
    # Real: the URL is certain and this one drives the "go try it" slide, where a
    # hatched placeholder would be worse than no code at all.
    ("qr-signup.png",     "https://app.pulumi.com/signup", "app.pulumi.com", False),
]

def font(size):
    for p in ("/System/Library/Fonts/SFNSMono.ttf",
              "/System/Library/Fonts/Supplemental/Andale Mono.ttf",
              "/System/Library/Fonts/Helvetica.ttc"):
        try:
            return ImageFont.truetype(p, size)
        except OSError:
            continue
    return ImageFont.load_default()

S = 560          # qr box
BAR = 92         # placeholder bar height
PAD = 18

for name, url, caption, provisional in ITEMS:
    qr = segno.make(url, error="h")
    tmp = OUT/("_tmp_"+name)
    # placeholders are muted so they never look finished; real ones use the brand violet
    qr.save(str(tmp), scale=20, dark=(MUTED if provisional else VIOLET),
            light="#ffffff", border=2)
    img = Image.open(tmp).convert("RGB").resize((S, S), Image.LANCZOS)

    if not provisional:
        # finished: just the code, no hatch, no bar, no border
        img.save(OUT/name)
        tmp.unlink()
        print(f"{name:18} -> {url}  (real)")
        continue

    canvas = Image.new("RGB", (S, S+BAR), "#ffffff")
    canvas.paste(img, (0, 0))
    d = ImageDraw.Draw(canvas)

    # diagonal hatch over the code so it reads as provisional at a glance
    hatch = Image.new("RGBA", (S, S), (0,0,0,0))
    hd = ImageDraw.Draw(hatch)
    for x in range(-S, S*2, 34):
        hd.line([(x, 0), (x+S, S)], fill=(126,107,255,38), width=13)
    canvas.paste(Image.alpha_composite(canvas.crop((0,0,S,S)).convert("RGBA"), hatch).convert("RGB"), (0,0))

    # bar
    d.rectangle([0, S, S, S+BAR], fill=VIOLET)
    f1, f2 = font(38), font(26)
    t = "PLACEHOLDER"
    w = d.textbbox((0,0), t, font=f1)[2]
    d.text(((S-w)//2, S+10), t, font=f1, fill="#ffffff")
    w2 = d.textbbox((0,0), caption, font=f2)[2]
    d.text(((S-w2)//2, S+54), caption, font=f2, fill="#e9e6ff")

    # border
    d.rectangle([0, 0, S-1, S+BAR-1], outline=VIOLET, width=5)
    canvas.save(OUT/name)
    tmp.unlink()
    print(f"{name:18} -> {url}  (placeholder)")
