// © 2025 John Gary Pusey (see LICENSE.md)

// Definition of Number should depend on which module is actually imported…

// public typealias Number = Complex

public typealias Number = Real

// public typealias Number = Fraction

// public typealias Number = ExactInteger

// === OR ===

// define separate protocols: ComplexRepresentable, RealRepresentable, etc.
