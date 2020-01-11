export default function() {
  return {
    user: "",
    ordersToday: [
      {
        order: {
          patient: {
            name: "Jill Johnson",
            street: "112 Forest Ln.",
            city: "Columbus",
            stateAbr: "OH",
            zipcode: "43203"
          },
          pharmacy: {
            name: "BetterRx",
            street: "1275 Kinnear Road",
            city: "Columbus",
            stateAbr: "OH",
            zipcode: "43201"
          },
          courier: {
            name: "Same Day Delivery",
            street: "900 Trenton Lane",
            city: "Trenton",
            stateAbr: "NJ",
            zipcode: "08536",
            pharmacies: [1, 2]
          },
          orderId: "123456",
          rxIds: ["RX123", "RX321"],
          pickupDate: "01-10-2020",
          pickupTime: "14:30",
          active: true,
          delivered: false,
          deliverable: true
        }
      },
      {
        patientName: "Gene Greyson",
        patientAddress: {
          street: "151 Oak Ln.",
          city: "Columbus",
          stateAbr: "OH",
          zipcode: "43203"
        },
        pharmacy: {
          name: "BetterRx",
          street: "1275 Kinnear Road",
          city: "Columbus",
          stateAbr: "OH",
          zipcode: "43201"
        },
        rxIds: ["RX123"],
        orderId: "123455",
        pickupDate: "01-10-2020",
        pickupTime: "15:30",
        active: true
      },
      {
        patientName: "Bob Bobson",
        patientAddress: {
          street: "111 Tree Ln.",
          city: "Columbus",
          stateAbr: "OH",
          zipcode: "43203"
        },
        pharmacy: {
          name: "BetterRx",
          street: "1275 Kinnear Road",
          city: "Columbus",
          stateAbr: "OH",
          zipcode: "43201"
        },
        rxIds: ["RX123"],
        orderId: "123457",
        pickupDate: "01-10-2020",
        pickupTime: "13:30",
        active: false
      }
    ]
  };
}
