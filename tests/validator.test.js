const { validateInsertData } = require("../refactored/interface/validators/tableValidator");

describe("Validator tests", () => {

  test("valid object", () => {
    expect(validateInsertData({ name: "John" })).toBe(true);
  });

  test("empty object", () => {
    expect(() => validateInsertData({})).toThrow("EMPTY_BODY");
  });

  test("null body", () => {
    expect(() => validateInsertData(null)).toThrow("INVALID_BODY");
  });

  test("undefined field", () => {
    expect(() => validateInsertData({ name: undefined }))
      .toThrow("INVALID_FIELD_name");
  });

  test("empty string", () => {
    expect(() => validateInsertData({ name: "" }))
      .toThrow("EMPTY_FIELD_name");
  });

  test("valid multiple fields", () => {
    expect(validateInsertData({ a: 1, b: "ok" })).toBe(true);
  });

  test("string with spaces", () => {
    expect(() => validateInsertData({ name: "   " }))
      .toThrow("EMPTY_FIELD_name");
  });

  test("number allowed", () => {
    expect(validateInsertData({ age: 20 })).toBe(true);
  });

  test("boolean allowed", () => {
    expect(validateInsertData({ active: true })).toBe(true);
  });

  test("multiple invalid fields", () => {
    expect(() => validateInsertData({ a: "", b: null }))
      .toThrow();
  });

});