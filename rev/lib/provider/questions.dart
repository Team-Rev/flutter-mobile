class Questions {
  static List<String> _questionList = [];
  static get questionList => _questionList;

  static List<Map<String, int>> _answerList = [];
  static get answerList => _answerList;

  static List<List<int>> _submitList = [];
  static get submitList => _submitList;

  static void init(List<Map<String,dynamic>> value) {
    _questionList.clear();
    _answerList.clear();
    _submitList=List.filled(questionLength,[]);
    for (int i = 0; i < value.length; i++) {
      _questionList.add(value[i]["exam"]);
      Map<String, int> answer = {};
      for (int j = 0; j < value[i]["choices"].length; j++) {
        answer.addAll(
            {value[i]["choices"][j]["choice"]: value[i]["choices"][j]["id"]});
      }
      _answerList.add(answer);
    }
  }
  static get questionLength => _question.length;
  static get question => _question;

  static var _question = [
    {
      "id": 1,
      "exam":
          "During a routine inspection, a technician discovered that software that was installed on a computer was secretly collecting data about websites that were visited by users of the computer. Which type of threat is affecting this computer?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {"id": 256, "isCorrect": true, "choice": "spyware", "questionId": 1},
        {
          "id": 3,
          "isCorrect": false,
          "choice": "zero-day attack",
          "questionId": 1
        },
        {"id": 1, "isCorrect": false, "choice": "DoS attack", "questionId": 1},
        {
          "id": 2,
          "isCorrect": false,
          "choice": "identity theft",
          "questionId": 1
        }
      ]
    },
    {
      "id": 2,
      "exam":
          "Which term refers to a network that provides secure access to the corporate offices by suppliers, customers and collaborators?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {"id": 4, "isCorrect": false, "choice": "Internet", "questionId": 2},
        {"id": 6, "isCorrect": false, "choice": "extendednet", "questionId": 2},
        {"id": 257, "isCorrect": true, "choice": "extranet", "questionId": 2},
        {"id": 5, "isCorrect": false, "choice": "intranet", "questionId": 2}
      ]
    },
    {
      "id": 3,
      "exam":
          "A large corporation has modified its network to allow users to access network resources from their personal laptops and smart phones. Which networking trend does this describe?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 9,
          "isCorrect": false,
          "choice": "video conferencing",
          "questionId": 3
        },
        {
          "id": 8,
          "isCorrect": false,
          "choice": "online collaboration",
          "questionId": 3
        },
        {
          "id": 258,
          "isCorrect": true,
          "choice": "bring your own device",
          "questionId": 3
        },
        {
          "id": 7,
          "isCorrect": false,
          "choice": "cloud computing",
          "questionId": 3
        }
      ]
    },
    {
      "id": 4,
      "exam": "What is an ISP?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 259,
          "isCorrect": true,
          "choice":
              "It is an organization that enables individuals and businesses to connect to the Internet.",
          "questionId": 4
        },
        {
          "id": 12,
          "isCorrect": false,
          "choice":
              "It is a networking device that combines the functionality of several different networking devices in one.",
          "questionId": 4
        },
        {
          "id": 10,
          "isCorrect": false,
          "choice":
              "It is a standards body that develops cabling and wiring standards for networking.",
          "questionId": 4
        },
        {
          "id": 11,
          "isCorrect": false,
          "choice":
              "It is a protocol that establishes how computers within a local network communicate.",
          "questionId": 4
        }
      ]
    },
    {
      "id": 5,
      "exam":
          "An employee at a branch office is creating a quote for a customer. In order to do this, the employee needs to access confidential pricing information from internal servers at the Head Office. What type of network would the employee access?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 13,
          "isCorrect": false,
          "choice": "the Internet",
          "questionId": 5
        },
        {
          "id": 260,
          "isCorrect": true,
          "choice": "an intranet",
          "questionId": 5
        },
        {
          "id": 14,
          "isCorrect": false,
          "choice": "an extranet",
          "questionId": 5
        },
        {
          "id": 15,
          "isCorrect": false,
          "choice": "a local area network",
          "questionId": 5
        }
      ]
    },
    {
      "id": 6,
      "exam":
          "Which statement describes the use of powerline networking technology?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 17,
          "isCorrect": false,
          "choice":
              "A home LAN is installed without the use of physical cabling.",
          "questionId": 6
        },
        {
          "id": 261,
          "isCorrect": true,
          "choice":
              "A device connects to an existing home LAN using an adapter and an existing electrical outlet.",
          "questionId": 6
        },
        {
          "id": 18,
          "isCorrect": false,
          "choice":
              "Wireless access points use powerline adapters to distribute data through the home LAN.",
          "questionId": 6
        },
        {
          "id": 16,
          "isCorrect": false,
          "choice":
              "New “smart” electrical cabling is used to extend an existing home LAN.",
          "questionId": 6
        }
      ]
    },
    {
      "id": 7,
      "exam":
          "A networking technician is working on the wireless network at a medical clinic. The technician accidentally sets up the wireless network so that patients can see the medical records data of other patients. Which of the four network characteristics has been violated in this situation?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 19,
          "isCorrect": false,
          "choice": "fault tolerance",
          "questionId": 7
        },
        {
          "id": 21,
          "isCorrect": false,
          "choice": "Quality of Service (QoS)",
          "questionId": 7
        },
        {"id": 262, "isCorrect": true, "choice": "security", "questionId": 7},
        {
          "id": 22,
          "isCorrect": false,
          "choice": "reliability",
          "questionId": 7
        },
        {"id": 20, "isCorrect": false, "choice": "scalability", "questionId": 7}
      ]
    },
    {
      "id": 8,
      "exam":
          "What two criteria are used to help select a network medium from various network media? (Choose two.)",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 263,
          "isCorrect": true,
          "choice":
              "the distance the selected medium can successfully carry a signal",
          "questionId": 8
        },
        {
          "id": 23,
          "isCorrect": false,
          "choice": "the types of data that need to be prioritized",
          "questionId": 8
        },
        {
          "id": 25,
          "isCorrect": false,
          "choice":
              "the number of intermediate devices installed in the network",
          "questionId": 8
        },
        {
          "id": 24,
          "isCorrect": false,
          "choice": "the cost of the end devices utilized in the network",
          "questionId": 8
        },
        {
          "id": 264,
          "isCorrect": true,
          "choice":
              "the environment where the selected medium is to be installed",
          "questionId": 8
        }
      ]
    },
    {
      "id": 9,
      "exam": "What type of network traffic requires QoS?",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 27,
          "isCorrect": false,
          "choice": "on-line purchasing",
          "questionId": 9
        },
        {"id": 26, "isCorrect": false, "choice": "email", "questionId": 9},
        {
          "id": 265,
          "isCorrect": true,
          "choice": "video conferencing",
          "questionId": 9
        },
        {"id": 28, "isCorrect": false, "choice": "wiki", "questionId": 9}
      ]
    },
    {
      "id": 10,
      "exam":
          "A user is implementing security on a small office network. Which two actions would provide the minimum security requirements for this network? (Choose two.)",
      "mainCategory": "CCNA 1 v7.0",
      "subCategory": "Modules 1 – 3\r",
      "totalCount": 0,
      "rightAnswerCount": 0,
      "choices": [
        {
          "id": 266,
          "isCorrect": true,
          "choice": "implementing a firewall",
          "questionId": 10
        },
        {
          "id": 29,
          "isCorrect": false,
          "choice": "installing a wireless network",
          "questionId": 10
        },
        {
          "id": 31,
          "isCorrect": false,
          "choice": "adding a dedicated intrusion prevention device",
          "questionId": 10
        },
        {
          "id": 267,
          "isCorrect": true,
          "choice": "installing antivirus software",
          "questionId": 10
        },
        {
          "id": 30,
          "isCorrect": false,
          "choice": "implementing an intrusion detection system",
          "questionId": 10
        }
      ]
    }
  ];
}
