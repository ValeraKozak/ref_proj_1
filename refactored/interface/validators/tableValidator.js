function validateInsertData(data) {
  if (!data || typeof data !== "object") {
    throw new Error("INVALID_BODY");
  }

  const keys = Object.keys(data);

  if (keys.length === 0) {
    throw new Error("EMPTY_BODY");
  }

  for (const key of keys) {
    const value = data[key];

    if (value === null || value === undefined) {
      throw new Error(`INVALID_FIELD_${key}`);
    }

    if (typeof value === "string" && value.trim() === "") {
      throw new Error(`EMPTY_FIELD_${key}`);
    }
  }

  return true;
}

module.exports = {
  validateInsertData,
};