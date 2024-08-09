const std = @import("std");
const CrossTarget = @import("std").zig.CrossTarget;
const Target = @import("std").Target;
const Feature = @import("std").Target.Cpu.Feature;

pub fn build(b: *std.Build) !void {
    const features = Target.riscv.Feature;
    var disabled_features = Feature.Set.empty;
    //const enabled_features = Feature.Set.empty;

    disabled_features.addFeature(@intFromEnum(features.a));
    disabled_features.addFeature(@intFromEnum(features.c));
    disabled_features.addFeature(@intFromEnum(features.d));
    disabled_features.addFeature(@intFromEnum(features.e));
    disabled_features.addFeature(@intFromEnum(features.f));

    //const target = CrossTarget{ .cpu_arch = Target.Cpu.Arch.riscv32, .os_tag = Target.Os.Tag.freestanding, .abi = Target.Abi.none, .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 }, .cpu_features_sub = disabled_features, .cpu_features_add = enabled_features };

    const target = getTarget(b);

    const exe = b.addExecutable(.{
        .name = "hello",
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = .ReleaseFast, // Debug doesn't work, emits illegal instructions (???)
        .strip = false,
    });

    //exe.setBuildMode(.ReleaseSmall);
    exe.setLinkerScriptPath(b.path("linker.ld"));
    b.installArtifact(exe);
}

fn getTarget(b: *std.Build) std.Build.ResolvedTarget {
    return b.resolveTargetQuery(.{
        .cpu_arch = std.Target.Cpu.Arch.riscv32,
        .ofmt = std.Target.ObjectFormat.elf,
        .abi = std.Target.Abi.none,
        .os_tag = std.Target.Os.Tag.freestanding,
    });
}
