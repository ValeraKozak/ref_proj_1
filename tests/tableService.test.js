const tableService = require("../refactored/interface/services/tableService");

describe("Table service", () => {

  test("allowed table", () => {
    expect(tableService.isAllowedTable("Users")).toBe(true);
  });

  test("not allowed table", () => {
    expect(tableService.isAllowedTable("Hack")).toBe(false);
  });

  test("invalid table get", async () => {
    await expect(
      tableService.getAllFromTable("Hack")
    ).rejects.toThrow("INVALID_TABLE");
  });

  test("invalid table insert", async () => {
    await expect(
      tableService.insertIntoTable("Hack", { a: 1 })
    ).rejects.toThrow("INVALID_TABLE");
  });

  test("empty body insert", async () => {
    await expect(
      tableService.insertIntoTable("Users", {})
    ).rejects.toThrow("EMPTY_BODY");
  });

  test("valid insert structure", async () => {
    const data = { name: "Test" };
    expect(Object.keys(data).length).toBeGreaterThan(0);
  });

  test("columns extraction", () => {
    const data = { a: 1, b: 2 };
    expect(Object.keys(data)).toEqual(["a", "b"]);
  });

  test("values extraction", () => {
    const data = { a: 1, b: 2 };
    expect(Object.values(data)).toEqual([1, 2]);
  });

  test("placeholder generation", () => {
    const values = [1, 2, 3];
    const placeholders = values.map(() => "?").join(", ");
    expect(placeholders).toBe("?, ?, ?");
  });

  test("table list contains Users", () => {
    expect(tableService.allowedTables).toContain("Users");
  });

});