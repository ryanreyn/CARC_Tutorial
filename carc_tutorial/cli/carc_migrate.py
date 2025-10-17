import subprocess
import sys
import pkg_resources
import argparse


def get_script_path(script_name: str) -> str:
    """Retrieve the full path to a bundled bash script."""
    return pkg_resources.resource_filename("carc_tutorial", f"scripts/{script_name}")


def main():
    parser = argparse.ArgumentParser(
        prog="carc-migrate",
        description="CLI for migrating files from one filesystem to another within the same compute cluster."
    )
    parser.add_argument(
        "-d", metavar="DIR", help="Directory to migrate (passed to run-migration.sh)"
    )
    parser.add_argument(
        "-t", metavar="TIME", help="Maximum walltime (days) for the migration job"
    )

    args = parser.parse_args()

    try:
        script_path = get_script_path("run-migration.sh")
        slurm_path = get_script_path("migrate.slurm")
        process_path = get_script_path("migrate.sh")
        subprocess.run(["bash", script_path, args.d, slurm_path, process_path, args.t], check=True)
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] Script '{script_path}' exited with code {e.returncode}", file=sys.stderr)
        sys.exit(e.returncode)
    except Exception as e:
        print(f"[ERROR] Failed to run '{script_path}': {e}", file=sys.stderr)
        sys.exit(1)
