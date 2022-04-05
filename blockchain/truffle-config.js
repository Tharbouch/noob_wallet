module.exports = {
  // Uncommenting the defaults below
  // provides for an easier quick-start with Ganache.
  // You can also follow this format for other networks.
  // See details at: https://trufflesuite.com/docs/truffle/reference/configuration
  // on how to specify configuration options!
  //
  networks: {
    development: {
      host: "192.168.0.154",
      port: 7545,
      network_id: "*"
    },
    test: {
      host: "192.168.0.154",
      port: 7545,
      network_id: "*"
    }
  },

};
