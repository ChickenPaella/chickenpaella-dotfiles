"""
Python REPL 환경 설정
PYTHONSTARTUP 환경변수로 자동 로드됨
"""
import os
import sys

# ── readline 히스토리 ─────────────────────────────────────────
try:
    import readline
    import atexit

    histfile = os.path.join(
        os.environ.get("XDG_DATA_HOME", os.path.expanduser("~/.local/share")),
        "python",
        "history",
    )
    os.makedirs(os.path.dirname(histfile), exist_ok=True)

    try:
        readline.read_history_file(histfile)
    except FileNotFoundError:
        pass

    readline.set_history_length(10000)
    atexit.register(readline.write_history_file, histfile)

    # tab 자동완성
    import rlcompleter
    readline.parse_and_bind("tab: complete")

except ImportError:
    pass

# ── 유용한 모듈 자동 import ───────────────────────────────────
import json
import re
from pathlib import Path
from pprint import pprint as pp

# ── 헬퍼 함수 ────────────────────────────────────────────────
def jprint(obj):
    """JSON 예쁘게 출력"""
    print(json.dumps(obj, indent=2, ensure_ascii=False, default=str))

def p(obj):
    """pprint 단축어"""
    pp(obj)

# ── REPL 시작 메시지 ─────────────────────────────────────────
if sys.flags.interactive:
    python_version = sys.version.split()[0]
    print(f"Python {python_version} | pp, jprint, Path, re 사용 가능")
