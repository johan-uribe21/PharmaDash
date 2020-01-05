export default function() {
  return {
    user: "",
    todaysOrders: [
      {
        patientName: "Jill Johnson",
        patientAddress: {
          street: "112 Forest Ln.",
          city: "Columbus",
          stateAbr: "OH",
          zipCode: "43203"
        },
        pharmacy: {
          name: "BetterRx",
          street: "1275 Kinnear Road",
          city: "Columbus",
          stateAbr: "OH",
          zipCode: "43201"
        },
        rxIds: ["RX123"],
        orderId: "123456",
        pickupDate: "01-10-2020",
        pickupTime: "14:30"
      },
      {
        patientName: "Gene Greyson",
        patientAddress: {
          street: "151 Oak Ln.",
          city: "Columbus",
          stateAbr: "OH",
          zipCode: "43203"
        },
        pharmacy: {
          name: "BetterRx",
          street: "1275 Kinnear Road",
          city: "Columbus",
          stateAbr: "OH",
          zipCode: "43201"
        },
        rxIds: ["RX123"],
        orderId: "123455",
        pickupDate: "01-10-2020",
        pickupTime: "15:30"
      },
      {
        patientName: "Bob Bobson",
        patientAddress: {
          street: "111 Tree Ln.",
          city: "Columbus",
          stateAbr: "OH",
          zipCode: "43203"
        },
        pharmacy: {
          name: "BetterRx",
          street: "1275 Kinnear Road",
          city: "Columbus",
          stateAbr: "OH",
          zipCode: "43201"
        },
        rxIds: ["RX123"],
        orderId: "123457",
        pickupDate: "01-10-2020",
        pickupTime: "13:30"
      }
    ]
  };
}
