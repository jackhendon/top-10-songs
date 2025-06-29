export function formatStreams(value) {
  const num = Number(value);
  return isFinite(num)
    ? new Intl.NumberFormat("en", {
        notation: "compact",
        maximumFractionDigits: 1,
      }).format(num)
    : "—";
}
