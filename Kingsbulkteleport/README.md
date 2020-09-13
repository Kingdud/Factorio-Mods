# Factorio Mod: Bulk Teleporters

Use spare gigajoules to teleport shipments of items.

## Dematerializer (sender)

* Sends item stacks to a Rematerializer
* Consumes 20MW for a 10s teleport cycle
* 250 item stack capacity

## Rematerializer (receiver)

* Receive item stacks from a Dematerializer
* Consumes 20MW for a 10s teleport cycle
* 250 item stack capacity

## Electricity consumption

Teleport cycles are deliberately expensive to run in order to be not too much of a cheat compared to trains. Once operating at scale teleport networks pretty much require their own dedicated nuclear supply, and massive accumulator buffers help when many teleport cycles run concurrently. Make use of those unloved efficiency modules and power switches to protect the rest of the grid from power spikes!

## Range multiplier

Distance extends the teleport cycle duration by 2 seconds per kilometre, which indirectly increases electricity consumption. This will probably eventually be rebalanced or turned into a mod setting.

## Teleport networks

Teleporters require an incoming circuit network signal to identify their network. Easiest way is to hook up a constant combinator. Only *virtual signals* are checked.

* 0-9 A-Z signals create networks
* red signal pauses teleportation unless a cycle has already started
* green signal immediately teleports a shipment regardless of size

The red signal is the nice way to stop. Flipping a power switch is more definite :)

Sub-nets are available: The number value of a virtual signal is taken into account. A(20) is a different network to A(17) and A(1000) etc.

## Load balancing

Dematerializers choose a target Rematerializer based on:

* Target is in one of their networks
* Target is not already running a cycle
* Target has some free space in its output buffer
* Target does not have a red signal

When multiple targets qualify the one with the most free space is chosen.

## UPS

UPS impact is quite light. Teleporters are checked once a second at most, and less frequently if a cycle is in progress. Any feedback on performance is welcome.
