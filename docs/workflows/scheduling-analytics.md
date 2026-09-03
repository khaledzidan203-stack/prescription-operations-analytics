# Generic Scheduling Analytics

This document describes a fictional scheduling model for portfolio analysis.

## Categories

- `Future`: scheduled date is after the configurable due window.
- `Due`: scheduled date falls inside the configured reporting window.
- `Overdue`: scheduled date is before the current business date.

## Configurable Window

Use a parameter such as `DueWindowDays = N`, where `N` is a fictional demo value selected for the synthetic scenario.

## Modeling Guidance

- Use a Date dimension.
- Define business date explicitly.
- Keep UTC timestamps separate from reporting dates where relevant.
- Ensure Due and Overdue categories do not overlap.
- Make the reporting window configurable rather than hardcoded.

## Example KPIs

Future Records, Due Records, Overdue Records, Average Days to Scheduled Date, and Overdue Rate.

## Publication Boundary

Do not publish real timing windows, refill rules, proprietary scheduling conditions, or private status names.