import 'package:flutter/material.dart';

/// Design tokens for Salam Vietnam colors.
/// Theme: Violet / Primary (#5234F4) · White / Surface (#FFFFFF) · Near Black (#191919) · Light Gray (#F3F3F3)
abstract class AppColors {
  // Brand Primary & Secondary (Violet Palette)
  static const Color violetPrimary = Color(
    0xFF5234F4,
  ); // Violet / Primary (#5234F4)
  static const Color violetLight = Color(0xFFEDE9FE); // Soft Violet tint
  static const Color violetDark = Color(0xFF3B1ED6); // Deep Violet

  static const Color nearBlack = Color(0xFF191919); // Near Black (#191919)
  static const Color lightGray = Color(0xFFF3F3F3); // Light Gray (#F3F3F3)

  // Primary Brand Color Aliases
  static const Color salamGreen = violetPrimary;
  static const Color salamGreenLight = Color(0xFF7C65F7);
  static const Color salamGreenDark = violetDark;
  static const Color oceanBlue = violetPrimary;

  static const Color warmSand = Color(0xFFD4A373);
  static const Color terracotta = Color(0xFFC05C46);
  static const Color softGold = Color(0xFFEDE9FE);

  // Surface & Background
  static const Color backgroundLight = Color(
    0xFFF3F3F3,
  ); // Light Gray (#F3F3F3)
  static const Color surfaceLight = Color(
    0xFFFFFFFF,
  ); // White / Surface (#FFFFFF)
  static const Color surfaceSubtle = Color(0xFFF3F3F3); // Light Gray (#F3F3F3)

  // Text Colors
  static const Color textPrimary = Color(0xFF191919); // Near Black (#191919)
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  // Halal Status Badges
  static const Color halalVerified = Color(0xFF10B981); // Emerald
  static const Color halalSelfDeclared = Color(0xFFF59E0B); // Amber
  static const Color halalUnverified = Color(0xFF64748B); // Slate
  static const Color halalExpired = Color(0xFFEF4444); // Red
  static const Color halalDisputed = Color(0xFFD97706); // Dark Amber

  // General Verification
  static const Color fieldVerified = Color(0xFF5234F4); // Violet
  static const Color sourceConfirmed = Color(0xFF0D9488); // Teal
  static const Color communityConfirmed = Color(0xFF8B5CF6); // Purple

  // Borders & Dividers
  static const Color borderSubtle = Color(0xFFE2E8F0);
}
