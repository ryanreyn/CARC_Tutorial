from setuptools import setup, find_packages

setup(
    name="carc_tutorial",
    version="0.1.0",
    packages=find_packages(),
    include_package_data=True,
    package_data={
        "carc_tutorial": ["scripts/*"]
    },
    entry_points={
        "console_scripts": [
            "carc-jobs-example = carc_tutorial.cli.carc_jobs_example:main",
            "carc-migrate = carc_tutorial.cli.carc_migrate:main",
            "carc-nf-example = carc_tutorial.cli.carc_nf_example:main"
        ]
    },
    install_requires=[],
    author="Ryan Reynolds",
    description="CLI tools for CARC cluster programming",
    classifiers=[
        "Programming Language :: Python :: 3",
        "Operating System :: POSIX :: Linux"
    ],
    python_requires=">=3.6"
)