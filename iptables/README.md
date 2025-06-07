# iptables-dsl

A toy domain-specific language (DSL) for writing firewall rules (iptable-style) in Racket. 

## FolderStructure

- `iptables-runtime.rkt` – Core IR builder functions (`chain`, `match`, `action`, etc.)
- `iptables-dsl.rkt` – DSL definition that enables `#lang iptables-dsl`
- `firewall.rkt` – Sample firewall rules written using the DSL or runtime

## Usage

Run the sample firewall program:
```bash
racket firewall.rkt
```
