#!/usr/bin/env python3

import os

def parse_args(args: [str]) -> dict:
    parsed = {
        "dest": None,
        "namespace": None,
        "bare": [],
        "class": [],
        "struct": []
    }

    current_mode = "class"

    idx = 0
    argc = len(args)
    while idx < argc:
        arg = args[idx]

        if arg == "-d":
            if idx + 1 < argc:
                parsed["dest"] = args[idx + 1]
                idx += 1
            else:
                print("Please specify a path when using -p")
                exit(1)
        elif arg == "-n":
            if idx + 1 < argc:
                parsed["namespace"] = args[idx + 1]
                idx += 1
            else:
                print("Please specify a namespace when using -n")
                exit(1)
        elif arg == "-b":
            current_mode = "bare"
        elif arg == "-c":
            current_mode = "class"
        elif arg == "-s":
            current_mode = "struct"
        elif arg.startswith("-"):
            print(f"Unknown flag: {arg}")
            exit(1)
        else:
            parsed[current_mode].append(arg)

        idx += 1
    return parsed

def get_namespace_lines(namespace: str, bare: bool=True) -> [str]:
    lines = []
    lines.append(f"namespace {namespace} {{\n")
    if bare:
        lines.append("\t\n")
    lines.append(f"}}\n")
    return lines

def get_class_lines(name: str, indent_level: int) -> [str]:
    lines = []
    indent = "\t" * indent_level
    name = name[0].upper() + name[1:]
    lines.append(f"{indent}class {name} {{\n")
    lines.append(f"{indent}\tpublic:\n")
    lines.append(f"{indent}\t{name}();\n")
    lines.append(f"{indent}\tprotected:\n")
    lines.append(f"{indent}\tprivate:\n")
    lines.append(f"{indent}}};\n")
    return lines

def get_struct_lines(name: str, indent_level: int) -> [str]:
    lines = []
    indent = "\t" * indent_level
    name = name[0].upper() + name[1:]
    lines.append(f"{indent}struct {name} {{\n")
    lines.append(f"{indent}\t\n")
    lines.append(f"{indent}}};\n")
    return lines

def get_constructor(name: str, indent_level: int) -> [str]:
    indent = "\t" * indent_level
    name = name[0].upper() + name[1:]
    return f'{indent}{name}::{name}() {{}}\n'

def create(settings: dict):
    if settings["dest"] and not os.path.exists(settings["dest"]):
        os.makedirs(settings["dest"], exist_ok=True)
    
    root = settings["dest"] or "."

    for bare in settings["bare"]:
        impl_path = f"{root}/{bare.lower()}.cpp"
        header_path = f"{root}/{bare.lower()}.hpp"
        if os.path.exists(impl_path) or os.path.exists(header_path):
            print(f"Files already exist for {bare}, skipping...")
            continue
        namespace = settings["namespace"]
        with open(header_path, "w") as file:
            lines = ["#pragma once\n", "\n"]
            if namespace:
                lines += get_namespace_lines(namespace)
            file.writelines(lines)
        with open(impl_path, "w") as file:
            lines = [f'#include "{bare.lower()}.hpp"\n', "\n"]
            if namespace:
                lines += get_namespace_lines(namespace)
            file.writelines(lines)
        print(f"Created files for {bare}!")

    for klass in settings["class"]:
        impl_path = f"{root}/{klass.lower()}.cpp"
        header_path = f"{root}/{klass.lower()}.hpp"
        if os.path.exists(impl_path) or os.path.exists(header_path):
            print(f"Files already exist for {klass}, skipping...")
            continue
        namespace = settings["namespace"]
        with open(header_path, "w") as file:
            lines = ["#pragma once\n", "\n"]
            if namespace:
                ns_lines = get_namespace_lines(namespace, False)
                lines.append(ns_lines[0])
                lines += get_class_lines(klass, 1)
                lines.append(ns_lines[1])
            else:
                lines += get_class_lines(klass, 0)
            file.writelines(lines)
        with open(impl_path, "w") as file:
            lines = [f'#include "{klass.lower()}.hpp"\n', "\n"]
            if namespace:
                ns_lines = get_namespace_lines(namespace, False)
                lines.append(ns_lines[0])
                lines.append(get_constructor(klass, 1))
                lines.append(ns_lines[1])
            else:
                lines.append(get_constructor(klass, 0))
            file.writelines(lines)
        print(f"Created files for {klass}!")

    for struct in settings["struct"]:
        header_path = f"{root}/{struct.lower()}.hpp"
        if os.path.exists(header_path):
            print(f"Files already exist for {struct}, skipping...")
            continue
        namespace = settings["namespace"]
        with open(header_path, "w") as file:
            lines = ["#pragma once\n", "\n"]
            if namespace:
                ns_lines = get_namespace_lines(namespace, False)
                lines.append(ns_lines[0])
                lines += get_struct_lines(struct, 1)
                lines.append(ns_lines[1])
            else:
                lines += get_struct_lines(struct, 0)
            file.writelines(lines)
            print(f"Created files for {struct}!")

if __name__ == "__main__":
    import sys
    argc = len(sys.argv)
    if argc == 1:
        print("Usage: touchcpp [-d <path>] [-n <namespace>] [-b|-c|-s] <units>")
        exit(0)
    if argc > 1:
        settings = parse_args(sys.argv[1:])
        create(settings)