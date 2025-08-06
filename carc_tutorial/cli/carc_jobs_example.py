import subprocess
import sys
import pkg_resources
import argparse


def get_script_path(script_name: str) -> str:
    """Retrieve the full path to a bundled bash script."""
    return pkg_resources.resource_filename("carc_tutorial", f"scripts/{script_name}")


def run_script(script_name: str, extra_args: list):
    """Run a script with optional extra arguments."""
    try:
        script_path = get_script_path(script_name)
        subprocess.run(["bash", script_path] + extra_args, check=True)
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] Script '{script_name}' exited with code {e.returncode}", file=sys.stderr)
        sys.exit(e.returncode)
    except Exception as e:
        print(f"[ERROR] Failed to run '{script_name}': {e}", file=sys.stderr)
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser(
        prog="carc-jobs-example",
        description="CLI for submitting jobs to CARC using spawn-runs.sh and jobs-submitter.sh"
    )

    subparsers = parser.add_subparsers(dest="command", required=True, help="Subcommand to run")

    # Subcommand: spawn
    parser_spawn = subparsers.add_parser(
        "spawn", help="Run spawn-runs.sh to set up jobs"
    )
    parser_spawn.add_argument("args", nargs=argparse.REMAINDER, help="Arguments passed to spawn-runs.sh")

    # Subcommand: submit
    parser_submit = subparsers.add_parser(
        "submit", help="Run jobs-submitter.sh to submit jobs via sbatch"
    )
    parser_submit.add_argument("args", nargs=argparse.REMAINDER, help="Arguments passed to jobs-submitter.sh")

    args = parser.parse_args()

    if args.command == "spawn":
        run_script("spawn-runs.sh", args.args)
    elif args.command == "submit":
        run_script("jobs-submitter.sh", args.args)
