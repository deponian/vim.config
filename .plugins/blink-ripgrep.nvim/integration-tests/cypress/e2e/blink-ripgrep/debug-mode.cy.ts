import { createGitReposToLimitSearchScope } from "./utils/createGitReposToLimitSearchScope"
import { verifyCorrectBackendWasUsedInTest } from "./utils/verifyGitGrepBackendWasUsedInTest"

describe("debug mode", () => {
  it("can execute the debug command in a shell", () => {
    cy.visit("/")
    cy.startNeovim({
      // also test that the plugin can handle spaces in the file path
      filename: "limited/dir with spaces/file with spaces.txt",
      startupScriptModifications: ["ripgrep/use_additional_paths.lua"],
    }).then((nvim) => {
      // wait until text on the start screen is visible
      cy.contains("this is file with spaces.txt")
      nvim.runExCommand({ command: `!mkdir "%:h/.git"` })

      // clear the current line and enter insert mode
      cy.typeIntoTerminal("cc")

      cy.typeIntoTerminal("spa")
      cy.contains("spaceroni-macaroni")

      nvim.runExCommand({ command: "messages" }).then((result) => {
        // make sure the logged command can be run in a shell
        expect(result.value)
        cy.log(result.value ?? "")

        cy.typeIntoTerminal("{esc}:term{enter}", { delay: 80 })

        // get the current buffer name
        nvim.runExCommand({ command: "echo expand('%')" }).then((bufname) => {
          cy.log(bufname.value ?? "")
          expect(bufname.value).to.contain("term://")
        })

        // start insert mode
        cy.typeIntoTerminal("a")

        // Quickly send the text over instead of typing it out. Cypress is a
        // bit slow when writing a lot of text.
        nvim.runLuaCode({
          luaCode: `vim.api.nvim_feedkeys([[${result.value}]], "n", true)`,
        })
        cy.typeIntoTerminal("{enter}")

        // The results will lbe 5-10 lines of jsonl.
        // Somewhere in the results, we should see the match, if the search was
        // successful.
        cy.contains(`spaceroni-macaroni`)

        // additional_paths should be used
        cy.contains("words.txt")
      })
    })
  })

  it("can clean up (kill) a previous rg search", () => {
    // to save resources, the plugin should clean up a previous search when a
    // new search is started. Blink should handle this internally, see
    // https://github.com/mikavilpas/blink-ripgrep.nvim/issues/102

    cy.visit("/")
    cy.startNeovim({}).then((nvim) => {
      // wait until text on the start screen is visible
      cy.contains("If you see this text, Neovim is ready!")
      createGitReposToLimitSearchScope()

      // clear the current line and enter insert mode
      cy.typeIntoTerminal("cc")

      // search for something that does not exist. This should start a couple
      // of searches
      cy.typeIntoTerminal("yyyyyy", { delay: 80 })
      nvim.runExCommand({ command: "messages" }).then((result) => {
        expect(result.value).to.contain(
          "killed previous RipgrepBackend invocation",
        )
      })
      nvim
        .runLuaCode({
          luaCode: `return _G.blink_ripgrep_invocations`,
        })
        .should((result) => {
          expect(result.value).to.be.an("array")
          expect(result.value).to.have.length.above(2)
        })
    })
  })

  it("can clean up (kill) a previous git grep search", () => {
    // to save resources, the plugin should clean up a previous search when a
    // new search is started. Blink should handle this internally, see
    // https://github.com/mikavilpas/blink-ripgrep.nvim/issues/102

    cy.visit("/")
    cy.startNeovim({
      startupScriptModifications: ["use_gitgrep_backend.lua"],
    }).then((nvim) => {
      // wait until text on the start screen is visible
      cy.contains("If you see this text, Neovim is ready!")
      createGitReposToLimitSearchScope()

      // clear the current line and enter insert mode
      cy.typeIntoTerminal("cc")

      // search for something that does not exist. This should start a couple
      // of searches
      cy.typeIntoTerminal("yyyyyy", { delay: 80 })
      nvim.runExCommand({ command: "messages" }).then((result) => {
        expect(result.value).to.contain(
          "killed previous GitGrepBackend invocation",
        )
      })
      nvim
        .runLuaCode({
          luaCode: `return _G.blink_ripgrep_invocations`,
        })
        .should((result) => {
          expect(result.value).to.be.an("array")
          expect(result.value).to.have.length.above(2)
        })

      verifyCorrectBackendWasUsedInTest("gitgrep")
    })
  })
})
