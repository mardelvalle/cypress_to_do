describe("My First Test", function() {
  it("Does not do much!", function() {
    expect(true).to.equal(true);
  });
});
describe("My First Test", function() {
  // the url should only be something that you control not external
  it("Visit Planner button", function() {
    cy.visit("http://localhost:4567");

    //not something like this
    // cy.visit("https://planner.com")

    // when can you test for text in something? I think it is when you know that the specific text will be there
    // target by attribute when possible. So not
    // cy.get("button");
    // cy.contains("Add a List");

    // attribute example
    cy.get("[data-cy=add-date]").contains(/^Add/);
  });
  it("Check that list text populates the next page", function() {
    cy.visit("/");

    cy.get("[data-cy=list-of-dates]")
      .find("input")
      .first()
      .invoke("text")
      .as("text");

    cy.get("[data-cy=list-of-dates]")
      .find("input")
      .first()
      .click();

    cy.get("[data-cy=add-date]").click();
    cy.url().should("include", "/to_do");
  });
});
